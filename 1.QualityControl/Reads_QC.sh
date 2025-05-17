#!/bin/bash

# Ensure PROJECT_DIR is defined
if [ -z "$PROJECT_DIR" ]; then
  echo "Error: PROJECT_DIR environment variable is not set. Please refer to 0.Environment_Setup.md for setup instructions."
  exit 1
fi

# Check that at least one input file was provided
if [ "$#" -lt 1 ]; then
  echo "Error: No input files provided."
  exit 1
fi

# Environment set-up
mkdir -p "$PROJECT_DIR/Reads_QC/LongQC"
mkdir -p "$PROJECT_DIR/Reads_QC/FastQC"
LONGQC="/cm/shared/apps/longqc/LongQC-1.2.0/longQC.py" # <-- Edit this line with the full path to the longQC.py script if you're not working on the LAVIS cluster
THREADS=20 # <-- Edit this line  with the number of threads according to your system's resources

# Quality Control for each sample
for INPUT in "$@"; do
  if [ ! -f "$INPUT" ]; then
    echo "Skipping: $INPUT file not found."
    continue
  fi
  
  # Extract sample name from file name
  SAMPLE_NAME=$(basename "$INPUT" | sed 's/_merged_raw_reads\.fastq//;s/\.fastq//;s/\.gz//')
  
  # Set output directory for LongQC
  LONGQC_OUT="$PROJECT_DIR/Reads_QC/LongQC/$SAMPLE_NAME"
  mkdir -p "$LONGQC_OUT"
  
  # Run LongQC
  echo "Running LongQC for $SAMPLE_NAME"
  python "$LONGQC" sampleqc -x pb-hifi -s "$SAMPLE_NAME" -p "$THREADS" -o "$LONGQC_OUT" "$INPUT"

  # Set output directory for FastQC
  FASTQC_OUT="$PROJECT_DIR/Reads_QC/FastQC/$SAMPLE_NAME"
  mkdir -p "$FASTQC_OUT"

  # Run FastQC
  echo "Running FastQC for $SAMPLE_NAME"
  fastqc -o "$FASTQC_OUT" "$INPUT"

  echo "Successful QC for $SAMPLE_NAME"
done
