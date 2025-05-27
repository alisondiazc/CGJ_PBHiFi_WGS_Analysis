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
mkdir -p "$PROJECT_DIR/Reads_Trimming"
cd "$PROJECT_DIR"

# Trimming process for each sample
for INPUT in "$@"; do
  if [ ! -f "$INPUT" ]; then
    echo "Skipping: $INPUT file not found."
    continue
  fi
  
  # Extract sample name from file name
  SAMPLE_NAME=$(basename "$INPUT" | sed 's/_merged_reads\.fastq\.gz$//; s/_merged_reads\.fastq$//; s/\.fastq\.gz$//; s/\.fastq$//')

  # Run HiFiAdapterFilt
  ## -l: minimum length of adapter match to remove
  ## -m: minimum percent match of adapter to remove
  ## -t: number of threads
  pbadapterfilt.sh -p "${SAMPLE_NAME}_merged_reads" -l 44 -m 97 -t 20 -o "${SAMPLE_NAME}_trimmed"

  # Move results to a specific folder
  mkdir -p "$PROJECT_DIR/Reads_Trimming/$SAMPLE_NAME"
  mv "${SAMPLE_NAME}_trimmed"* "$PROJECT_DIR/Reads_Trimming/$SAMPLE_NAME/"
  echo "Trimming for $SAMPLE_NAME completed. Output files at $PROJECT_DIR/Reads_Trimming/$SAMPLE_NAME/"

done
