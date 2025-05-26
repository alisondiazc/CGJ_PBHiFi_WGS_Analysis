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
mkdir -p "$PROJECT_DIR/GRCh38_alignment"
cd "$PROJECT_DIR"
## Path to reference genome files (adjust if needed)
REF_FASTA=/mnt/Timina/cgonzaga/resources/GRCh38.14/Homo_sapiens_GRCh38.p14.noMT.names.fasta
REF_INDEX=/mnt/Timina/cgonzaga/resources/GRCh38.14/Homo_sapiens_GRCh38.p14.noMT.names.fasta.fai

# Alignment of Reads to GRCh38 for Each Sample
for INPUT in "$@"; do
  if [ ! -f "$INPUT" ]; then
    echo "Skipping: $INPUT file not found."
    continue
  fi

  # Extract sample name from file name 
  




  # Extract sample name from file name
  SAMPLE_NAME=$(basename "$INPUT" | sed 's/_merged_raw_reads\.fastq//;s/\.fastq//;s/\.gz//')

  # Run HiFiAdapterFilt
  ## -l: minimum length of adapter match to remove
  ## -m: minimum percent match of adapter to remove
  ## -t: number of threads
  pbadapterfilt.sh -p "${SAMPLE_NAME}_merged_raw_reads" -l 44 -m 97 -t 20 -o "${SAMPLE_NAME}_trimmed"

  # Move results to a specific folder
  mkdir -p "$PROJECT_DIR/Reads_Trimming/$SAMPLE_NAME"
  mv "${SAMPLE_NAME}_trimmed"* "$PROJECT_DIR/Reads_Trimming/$SAMPLE_NAME/"
  echo "Trimming for $SAMPLE_NAME completed. Output files at $PROJECT_DIR/Reads_Trimming/$SAMPLE_NAME/"

done
