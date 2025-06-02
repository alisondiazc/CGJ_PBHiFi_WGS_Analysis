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
## Create output directory
mkdir -p "$PROJECT_DIR/CHM13-T2T_alignment"
cd "$PROJECT_DIR"
## Path to reference genome files (adjust if needed)
### Note: The index file (*.fai) has to be in the same directory as the Reference
REF_FASTA=/mnt/Timina/cgonzaga/resources/T2T_2.0/chm13v2.0.noMT.names.fa

# Alignment of Reads to CHM13-T2T for Each Sample
for INPUT in "$@"; do
  if [ ! -f "$INPUT" ]; then
    echo "Skipping: $INPUT file not found."
    continue
  fi

  # Extract sample name from file name 
  SAMPLE_NAME=$(basename "$INPUT" | sed 's/\.filt\.fastq\.gz$//; s/\.fastq\.gz$//; s/\.fastq$//')
  mkdir -p "$PROJECT_DIR/CHM13-T2T_alignment/$SAMPLE_NAME"

  # Reads alignment with pbmm2
  ## -j: number of threads
  echo "Starting the alignment of $SAMPLE_NAME reads against CHM13-T2T human reference"
  pbmm2 align --sort -j 20 --preset HIFI --log-level INFO "$REF_FASTA" "$INPUT" "$PROJECT_DIR/CHM13-T2T_alignment/$SAMPLE_NAME/${SAMPLE_NAME}.CHM13-T2T.pbmm2.bam"
  echo "Alignment of $SAMPLE_NAME to CHM13-T2T completed. Output files at $PROJECT_DIR/CHM13-T2T_alignment/"

done
