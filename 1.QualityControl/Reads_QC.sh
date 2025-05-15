#!/bin/bash

# Ensure PROJECT_DIR is defined
if [ -z "$PROJECT_DIR" ]; then
  echo "Error: PROJECT_DIR environment variable is not set. Please refer to 0.Environment_Setup.md for setup instructions."
  exit 1
fi

# Environment Set Up
mkdir -p "$PROJECT_DIR/Reads_QC"
mkdir -p "$PROJECT_DIR/Reads_QC/LongQC"
mkdir -p "$PROJECT_DIR/Reads_QC/FastQC"

# Define variables 
LONGQC="/cm/shared/apps/longqc/LongQC-1.2.0/longQC.py" # <-- Edit this line with the full path to the longQC.py script (not necessary if you're working on the LAVIS cluster)
SAMPLE_NAME="PYM007" # <-- Edit this line with your sample name
THREADS=20 # <-- Edit this line  with the number of threads according to your system's resources
OUTPUT_DIR="$PROJECT_DIR/Reads_QC/LongQC"
INPUT="$PROJECT_DIR/Raw_reads/${SAMPLE_NAME}_merged_raw_reads.fastq"

# LongQC run 
python "$LONGQC" sampleqc -x pb-hifi -s "$SAMPLE_NAME" -p "$THREADS" -o "$OUTPUT_DIR" "$INPUT"

# FastQC run 
cd "$PROJECT_DIR/Reads_QC/FastQC"
fastqc "$INPUT" 
