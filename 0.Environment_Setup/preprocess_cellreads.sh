#!/bin/bash

# Ensure PROJECT_DIR is defined
if [ -z "$PROJECT_DIR" ]; then
  echo "Error: PROJECT_DIR environment variable is not set. Please refer to 0.Environment_Setup.md for setup instructions."
  exit 1
fi

# Set sample name
SAMPLE_NAME="PYM007" # <-- Edit this line with your sample name

# Create a directory for Raw reads
mkdir "$PROJECT_DIR/Unmerged_reads"
mv "$PROJECT_DIR"/*.bam "$PROJECT_DIR/Unmerged_reads/"
cd "$PROJECT_DIR/Unmerged_reads"

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
if ls *.fastq 1> /dev/null 2>&1; then
  cat *.fastq > "${SAMPLE_NAME}_merged_reads.fastq"
  gzip "${SAMPLE_NAME}_merged_reads.fastq"
  echo "FASTQ file merging and compression completed. Concatenated file: ${SAMPLE_NAME}_merged_reads.fastq.gz"
else
  echo "Error: No FASTQ files found in Raw_reads directory"
  exit 1
fi

# Move the merged fastq file to the main directory 
mv ${SAMPLE_NAME}_merged_reads.fastq.gz "$PROJECT_DIR"
