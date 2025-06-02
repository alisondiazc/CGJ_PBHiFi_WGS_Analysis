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
# Path to plot-dist.py mosdepth script (adjust if needed)
PLOT_DIST=$PROJECT_DIR/scripts/plot-dist.py
# Path to pafCoordsDotPlotly.R dotPlotly script (adjust if needed)
DotPlot_SCRIPT=$PROJECT_DIR/scripts/pafCoordsDotPlotly.R

# Alignment of Reads to GRCh38 for Each Sample
for INPUT in "$@"; do
  if [ ! -f "$INPUT" ]; then
    echo "Skipping: $INPUT file not found."
    continue
  fi

  # Extract sample name from file name 
  SAMPLE_NAME=$(basename "$INPUT" | sed 's/\.filt\.fastq\.gz$//; s/\.fastq\.gz$//; s/\.fastq$//')
  mkdir -p "$PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME"

  # Reads alignment with pbmm2
  ## -j: number of threads
  echo "Starting the alignment of $SAMPLE_NAME reads against GRCh38 human reference"
  pbmm2 align --sort -j 20 --preset HIFI --log-level INFO "$REF_FASTA" "$INPUT" "$PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/${SAMPLE_NAME}.GRCh38.pbmm2.bam"
  echo "Alignment of $SAMPLE_NAME to GRCH38 completed. Output files at $PROJECT_DIR/GRCh38_alignment/"

  # Quality Control process of the obtained alignment (adjust or delete steps if needed)
  
  ## Coverage analysis with Mosdepth
  echo "Starting the coverage analysis of $SAMPLE_NAME aligment vs GRCh38 with mosdepth"
  mkdir -p "$PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/mosdepth"
  cd "$PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/mosdepth"
  ### -t: number of threads
  mosdepth -t 20 -n "${SAMPLE_NAME}.GRCh38" "$PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/${SAMPLE_NAME}.GRCh38.pbmm2.bam"
  python "$PLOT_DIST" "${SAMPLE_NAME}.GRCh38.mosdepth.global.dist.txt"
  cd "$PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/"
  echo "Coverage analysis of $SAMPLE_NAME completed. Output files at $PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/mosdepth"

  ## Consensus sequence generation with Samtools
  echo "Starting the generation of a consensus sequence for $SAMPLE_NAME with Samtools"
  samtools consensus -f fasta -o "$SAMPLE_NAME.GRCh38.cons.fa" -a "${SAMPLE_NAME}.GRCh38.pbmm2.bam"
  echo "Consensus sequence for $SAMPLE_NAME generated. Output file at $PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/"

  ## Quality Control statistics of consensus sequence with assembly-stats 
  echo "Starting $SAMPLE_NAME consensus sequence statistics generation with assembly-stats"
  mkdir -p "$PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/assembly-stats"
  assembly-stats "$SAMPLE_NAME.GRCh38.cons.fa" > "$PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/assembly-stats/$SAMPLE_NAME.GRCh38.cons.stats"
  echo "Consensus sequence statistics for $SAMPLE_NAME generated. Output file at $PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/assembly-stats"

  # Consensus sequence alignment to the Reference Genome with Minimap2
  echo "Starting alignment of $SAMPLE_NAME consensus to GRCh38 with Minimap2"
  ## --secondary: enables reporting of secondary alignments
  ## -t: number of threads
  minimap2 -x asm5 -L --secondary=no -t 20 "$REF_FASTA" "$SAMPLE_NAME.GRCh38.cons.fa" > "$SAMPLE_NAME.GRCh38.cons.mm2.paf"
  echo "Consensus sequence statistics for $SAMPLE_NAME generated. Output file at $PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/"

  # Dot plot generation with dotPlotly
  echo "Starting dot plot of $SAMPLE_NAME consensus alignment to GRCh38 using dotPlotly"
  mkdir -p "$PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/dotPlotly"
  "$DotPlot_SCRIPT" -i "$SAMPLE_NAME.GRCh38.cons.mm2.paf" -o "$PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/dotPlotly/$SAMPLE_NAME.GRCh38" -s -t -l
  echo "Dot plot of $SAMPLE_NAME consensus alignment to GRCh38 generated. Outputs at $PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/dotPlotly"

  # Genome quality report generation with QUAST 
  echo "Starting dot plot of $SAMPLE_NAME consensus alignment to GRCh38 using dotPlotly"






  
  
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
