# 🧬 Bioinformatics Pipeline for the Analysis of Human Whole Genome Sequencing (WGS) Data Using PacBio HiFi

This repository contains the implementation of a bioinformatics pipeline for assembling and analysing human whole genome sequencing data using long-read PacBio HiFi technology. The objective is to compare different assembly strategies (reference-based alignment using GRCh38 and T2T, and a *de novo* assembly) as well as assess their impact on the detection of genetic variation, from single-nucleotide variants (SNVs) to structural variation (SVs).

---

## 📂 Repository Structure

- `scripts/` – Bash and Python scripts for alignment, assembly, QC, and variant calling.
- `notebooks/` – Jupyter notebooks for exploratory data analysis and visualization.
- `data/` – Sample data or links to public test datasets (no raw patient data included).
- `results/` – Processed outputs, metrics, and figures.
- `docs/` – Supplementary documentation and figures used in the thesis.

---

## ⚙️ Pipeline Overview

---
## 🧰 Tools and Software

- **Minimap2 / pbmm2** – Long-read aligners  
- **hifiasm / flye** – *De novo* genome assemblers  
- **QUAST / BUSCO** – Assembly evaluation and gene completeness metrics  
- **SyRi** – Genome synteny and rearrangement identification  
- **Sniffles2 / pbsv / SVIM** – Structural variant callers  
- **bcftools / bedtools / vcftools** – Variant filtering and comparison  
- **Python / R** – Data processing, visualization, and statistical analysis

---

## 📊 Expected Outputs

- Assembly metrics (e.g., N50, total length, duplication ratio, misassemblies)  
- Synteny plots and rearrangement calls between references and assembled genomes  
- VCF comparisons for SNVs and SVs across reference alignments  
- Summary statistics and figures for use in publications and thesis documentation

---

## 👩‍🔬 Author

**Alison Díaz Cuevas**  
Bachelor’s Student in Genomic Biotechnology at Autonomous University of Nuevo Leon, Mexico
Thesis Project developed at the International Laboratory for Human Genome Research (LIIGH), UNAM  
Supervisor: **Dr. Claudia Gonzaga Jáuregui**

---

## 📬 Contact

For questions, feedback, or collaboration inquiries:  
📧 alison.m.b.g@gmail.com
📧 cgonzaga@liigh.unam.mx

---

