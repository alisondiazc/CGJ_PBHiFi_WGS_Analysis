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
### Note: The index file (*.fai) has to be in the same directory as the Reference
REF_FASTA=/mnt/Timina/cgonzaga/resources/GRCh38.14/Homo_sapiens_GRCh38.p14.noMT.names.fasta
# Path to plot-dist.py mosdepth script
PLOT_DIST=$PROJECT_DIR/scripts/plot-dist.py

# Alignment of Reads to GRCh38 for Each Sample
for INPUT in "$@"; do
  if [ ! -f "$INPUT" ]; then
    echo "Skipping: $INPUT file not found."
    continue
  fi

  # Extract sample name from file name 
  SAMPLE_NAME=$(basename "$INPUT" | sed 's/\.filt\.fastq\.gz$//; s/\.fastq\.gz$//; s/\.fastq$//')
  mkdir -p "$PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME"

  # Align reads with pbmm2
  ## -j: number of threads
  echo "Starting the alignment of $SAMPLE_NAME reads against GRCh38 human reference"
  pbmm2 align --sort -j 20 --preset HIFI --log-level INFO "$REF_FASTA" "$INPUT" "$PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/${SAMPLE_NAME}.GRCh38.pbmm2.bam"
  echo "Alignment of $SAMPLE_NAME to GRCH38 completed. Output files at $PROJECT_DIR/GRCh38_alignment/"

  # Quality Control process of the obtained alignment (adjust or delete steps if needed)
  ## Coverage analysis with Mosdepth
  ### -t: number of threads
  echo "Starting the coverage analysis of $SAMPLE_NAME aligment vs GRCh38 with mosdepth"
  mkdir -p "$PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/mosdepth"
  cd "$PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/mosdepth"
  mosdepth -t 20 -n "${SAMPLE_NAME}.GRCh38" "$PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/${SAMPLE_NAME}.GRCh38.pbmm2.bam"
  
  



  
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
