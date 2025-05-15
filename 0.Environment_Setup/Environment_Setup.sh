#!/bin/bash

# Ensure PROJECT_DIR is defined
if [ -z "$PROJECT_DIR" ]; then
  echo "Error: PROJECT_DIR environment variable is not set. Please refer to 0.Environment_Setup.md for setup instructions."
  exit 1
fi

# Create reads/ directory
mkdir "$PROJECT_DIR/Raw_reads"
cd "$PROJECT_DIR/Raw_reads"

# Convert ubam files in reads/ to .fastq
for bam_file in *.bam; do
  if [ -f "$bam_file" ]; then
    bam2fastq "$bam_file"
    
  else
    echo "⚠️ No BAM files found in $PROJECT_DIR/reads/"
    exit 1
  fi
done
