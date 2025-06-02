#!/usr/bin/env Rscript

# Load libraries
library(ggplot2)
library(pafr)
cat("Libraries loaded successfully.\n")

# Get input arguments
args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 2) {
  stop("Error: Missing input arguments.\n Usage: plot_pafr.R <input.paf> <output.png>")
}

paf_file <- args[1]
output_file <- args[2]

# Load PAF file
paf <- read_paf(paf_file)

# Define chromosome order (adapt if needed)
chroms <- c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "X", "Y")
paf$tname <- factor(paf$tname, levels = chroms)
paf$qname <- factor(paf$qname, levels = chroms)

# Define colour palette
palette <- c('#07948e','#3d8e6f','#728751','#ECB004','#de7b13','#FE7701','#f86a29','#f36046','#ee5663','#E94B86','#ea5d6f','#ea7353','#eb8837','#eb9e1b','#e5b00d','#c0b139','#9cb265','#78b391','#54b4bd','#45B4CF','#3fa7cf','#3b9fcf','#3896cf','#348ecf')

# Plotting
plot <- plot_coverage(paf, fill = 'qname') + scale_fill_manual(values = palette)

# Save plot as PNG (adapt dimensions if needed)
ggsave(filename = output_file, plot = plot, width = 10, height = 8, dpi = 300)
