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

# Trimming process for each sample
for INPUT in "$@"; do
  if [ ! -f "$INPUT" ]; then
    echo "Skipping: $INPUT file not found."
    continue
  fi
  
  # Extract sample name from file name
  SAMPLE_NAME=$(basename "$INPUT" | sed 's/_merged_raw_reads\.fastq//;s/\.fastq//;s/\.gz//')

  # Set output directory
  TRIMMING_OUT="$PROJECT_DIR/Reads_Trimming/$SAMPLE_NAME"
  mkdir -p "$TRIMMING_OUT"

  # Run HiFiAdapterFilt
  echo "Running LongQC for $SAMPLE_NAME"
  pbadapterfilt.sh \
    -p ./ \ 
    -l 44 \ <-- Minimum Length of adapter match to remove. 
    -m 97 \ <-- Minimum percent Match of adapter to remove
    -t 20 \ <-- Number of threads
    -o "$TRIMMING_OUT"
  echo "Trimming for $SAMPLE_NAME completed. Output files at $TRIMMING_OUT"
done
