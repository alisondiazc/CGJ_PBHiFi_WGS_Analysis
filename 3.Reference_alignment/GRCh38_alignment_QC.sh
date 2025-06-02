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
cd "$PROJECT_DIR"
## Path to reference genome files (adjust if needed)
### Note: The index file (*.fai) has to be in the same directory as the Reference
REF_FASTA=/mnt/Timina/cgonzaga/resources/GRCh38.14/Homo_sapiens_GRCh38.p14.noMT.names.fasta
# Path to plot-dist.py mosdepth script (adjust if needed)
PLOT_DIST=$PROJECT_DIR/scripts/plot-dist.py
# Path to quast.py script (adjust if needed)
QUAST_SCRIPT=$PROJECT_DIR/scripts/quast.py
# Path to pafCoordsDotPlotly.R dotPlotly script (adjust if needed)
DotPlot_SCRIPT=$PROJECT_DIR/scripts/pafCoordsDotPlotly.R
# Path to pafr_plotting.R script (adjust if needed)
PAFR_SCRIPT=$PROJECT_DIR/scripts/pafr_plotting.R

# Quality Control of each alignment against GRCh38 (adjust or delete steps if needed)
for INPUT in "$@"; do
  if [ ! -f "$INPUT" ]; then
    echo "Skipping: $INPUT file not found."
    continue
  fi

  # Extract sample name from file name 
  SAMPLE_NAME=$(basename "$INPUT" | sed 's/\.GRCh38\.pbmm2\.bam$//')
  
  ## Coverage analysis with Mosdepth
  echo "Starting the coverage analysis of $SAMPLE_NAME alignment vs GRCh38 with mosdepth"
  mkdir -p "$PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/mosdepth"
  cd "$PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/mosdepth"
  ### -t: number of threads
  mosdepth -t 20 -n "${SAMPLE_NAME}.GRCh38" "$PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/${SAMPLE_NAME}.GRCh38.pbmm2.bam"
  python "$PLOT_DIST" "${SAMPLE_NAME}.GRCh38.mosdepth.global.dist.txt"
  cd "$PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/"
  echo "Coverage analysis of $SAMPLE_NAME completed. Output files at $PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/mosdepth"

  ## Consensus sequence generation with Samtools
  echo "Starting the generation of a consensus sequence for $SAMPLE_NAME with Samtools"
  samtools consensus -f fasta -o "${SAMPLE_NAME}.GRCh38.cons.fa" -a "${SAMPLE_NAME}.GRCh38.pbmm2.bam"
  echo "Consensus sequence for $SAMPLE_NAME generated. Output file at $PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/"

  ## Quality Control statistics of consensus sequence with assembly-stats 
  echo "Starting $SAMPLE_NAME consensus sequence statistics generation with assembly-stats"
  mkdir -p "$PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/assembly-stats"
  assembly-stats "${SAMPLE_NAME}.GRCh38.cons.fa" > "$PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/assembly-stats/${SAMPLE_NAME}.GRCh38.cons.stats"
  echo "Consensus sequence statistics for $SAMPLE_NAME generated. Output file at $PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/assembly-stats"

  # Genome quality report generation with QUAST 
  echo "Generating quality report for $SAMPLE_NAME consensus sequence with QUAST"
  ## -t: number of threads
  python "$QUAST_SCRIPT" -t 20 --large -o "$PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/QUAST" -r "$REF_FASTA" "${SAMPLE_NAME}.GRCh38.cons.fa"
  echo "Quality report for $SAMPLE_NAME consensus sequence generated. Output files at $PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/QUAST"
  
  # Consensus sequence alignment to the Reference Genome with Minimap2
  echo "Starting alignment of $SAMPLE_NAME consensus to GRCh38 with Minimap2"
  ## --secondary: enables reporting of secondary alignments
  ## -t: number of threads
  minimap2 -x asm5 -L --secondary=no -t 20 "$REF_FASTA" "${SAMPLE_NAME}.GRCh38.cons.fa" > "${SAMPLE_NAME}.GRCh38.cons.mm2.paf"
  echo "Consensus sequence statistics for $SAMPLE_NAME generated. Output file at $PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/"
  
  # Dot plot generation with dotPlotly
  echo "Starting dot plot of $SAMPLE_NAME consensus sequence to GRCh38 using dotPlotly"
  mkdir -p "$PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/dotPlotly"
  "$DotPlot_SCRIPT" -i "${SAMPLE_NAME}.GRCh38.cons.mm2.paf" -o "$PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/dotPlotly/${SAMPLE_NAME}.GRCh38" -s -t -l
  echo "Dot plot of $SAMPLE_NAME consensus alignment to GRCh38 generated. Outputs at $PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/dotPlotly"
  
  # Coverage plot generation with pafr
  echo "Starting coverage plotting of $SAMPLE_NAME consensus to GRCh38 with pafr"
  mkdir -p "$PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/pafr"
  Rscript "$PAFR_SCRIPT" "${SAMPLE_NAME}.GRCh38.cons.mm2.paf" "$PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/pafr/${SAMPLE_NAME}.GRCh38.covplot.png"
  echo "Coverage plot for $SAMPLE_NAME consensus to GRCh38 generated. Output file at $PROJECT_DIR/GRCh38_alignment/$SAMPLE_NAME/pafr"
  
done
