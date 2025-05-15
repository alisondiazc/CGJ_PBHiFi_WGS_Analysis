#!/bin/bash

# Ensure PROJECT_DIR is defined
if [ -z "$PROJECT_DIR" ]; then
  echo "Error: PROJECT_DIR environment variable is not set. Please refer to 0.Environment_Setup.md for setup instructions."
  exit 1
fi

# Create a directory for Raw reads
mkdir "$PROJECT_DIR/Raw_reads"
mv "$PROJECT_DIR"/*.bam "$PROJECT_DIR/Raw_reads/"
cd "$PROJECT_DIR/Raw_reads"

# Convert ubam files in reads/ to .fastq
for bam_file in *.bam; do
  if [ -f "$bam_file" ]; then
    bam2fastq "$bam_file"
    echo "Conversion from BAM to FASTQ completed."
  else
    echo "Error: No BAM files found in Raw_reads directory"
    exit 1
  fi
done

# Merge all .fastq files into one
if [ -f *.fastq ]; then
  cat *.fastq > merged_raw_reads.fastq
  gzip merged_raw_reads.fastq
  echo "FASTQ file merging and compression completed. Concatenated file: merged_raw_reads.fastq"
else
  echo "Error: No FASTQ files found in Raw_reads directory"
  exit 1
fi
