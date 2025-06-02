# 3. Read Alignment to Reference Genomes
*** 

## Requirements
### Genome Alignment Process
- [pbmm2](https://github.com/PacificBiosciences/pbmm2) v.1.12.0 or later installed and accessible in your environment
### Post-Alignment Quality Control tools
- R v.4.0.2 or later installed and accessible in your environment
- Python v.3.3 or later installed and accessible in your environment
- [mosdepth](https://github.com/brentp/mosdepth) v.0.3.3 or later installed and accessible in your environment
- [samtools](https://github.com/samtools/samtools) v.1.16.1 or later installed and accessible in your environment
- [assembly-stats](https://github.com/sanger-pathogens/assembly-stats) v.1.0.1 or later installed and accessible in your environment
- [minimap2](https://github.com/lh3/minimap2) v.2.24.0 or later installed and accessible in your environment
- [pafr](https://github.com/dwinter/pafr) library installed and accessible in your environment
> If you're using the LAVIS Cluster, load the programs as follows:
  ```bash
# pbmm2 is pre-loaded in miniconda
module load miniconda/4.3.1
module load r/4.0.2
module load python38/3.8.3
module load mosdepth/0.3.3
module load samtools/1.16.1
module load assembly-stats/1.0.1
module load minimap2/2.24
  ```
### Post-Alignment Quality Control scripts
- [mosdepth](https://github.com/brentp/mosdepth) script `plot-dist.py` accessible in your environment
- [QUAST](https://quast.sourceforge.net/) script `quast.py` accessible in your environment
- [dotPlotly](https://github.com/tpoorten/dotPlotly) script `pafCoordsDotPlotly.R` accessible in your environment
- `pafr_plotting.R` script (included in this repository) accessible in your environment
> Once downloaded, you will need to change the permissions of the files as follows:
  ```bash
chmod 777 plot-dist.py
chmod 777 quast.py
chmod 777 pafCoordsDotPlotly.R
chmod 777 pafr_plotting.R
  ```
*** 

## Instructions
> **Note:** Before proceeding with the following steps, ensure that the PROJECT_DIR environment variable is properly defined. To verify that it is set correctly, you can run:  
```bash
echo $PROJECT_DIR
```
> If the output shows the correct path, you're ready to proceed. If it returns nothing, you'll need to export it again or check your shell configuration. Refer to step 0 for detailed instructions.

### 1. Read Alignment Against a Reference Genome (GRCh38 or CHM13-T2T)

1. Download the appropriate script from this repository, based on the reference genome you plan to use, and place it in the `$PROJECT_DIR/` directory:
   - `GRCh38_alignment.sh` for aligning reads to GRCh38 reference genome  
   - `CHM13-T2T_alignment.sh` for aligning reads to CHM13-T2T reference genome

2. Configure the script by editing the variables listed in the **"Environment set-up"** and **"# Reads alignment with pbmm2"** sections:
   - `REF_FASTA`: Full path to the reference genome `.fasta` file. **Note:** The corresponding index file (`.fai`) has to be located in the same directory as the FASTA file.
   - `-j`: Number of threads

3. Run the script as follows, replacing the text inside brackets. **Note:** The script supports multiple inputs, but each file must follow the naming convention `*.fastq` (raw reads) or `*_merged_reads.fastq` (trimmed reads).
   ```bash
   # Give the script execution permissions
   chmod +x [Reference_Genome]_alignment.sh
   # Run the script
   ./[Reference_Genome]_alignment.sh [Sample1].fastq [Sample2].fastq
   ```

### 2. Quality Control of the obtained genome alignment 

1. Download the appropriate QC script from this repository, based on the reference genome you used in the previous step, and place it in the `$PROJECT_DIR/` directory:
   - `GRCh38_alignment_QC.sh` for GRCh38-based alignment
   - `CHM13-T2T_alignment_QC.sh` for CHM13-T2T-based alignment

2. Configure the script by editing the required variables throughout the file:
   - `REF_FASTA`: Full path to the reference genome `.fasta` file. **Note:** The corresponding index file (`.fai`) has to be located in the same directory as the FASTA file.
   - `PLOT_DIST`: Full path to the `plot-dist.py` mosdepth script
   - `QUAST_SCRIPT`: Full path to the `quast.py` script
   - `DotPlot_SCRIPT`: Full path to the `pafCoordsDotPlotly.R` dotPlotly script
   - `PAFR_SCRIPT`: Full path to the `pafr_plotting.R` script
   - `-t`: Number of threads
   - `--secondary`: Controls whether secondary alignments are reported

3. Run the script as follows, replacing the text inside brackets. **Note:** The script supports multiple inputs, but each file must follow the naming convention `*.GRCh38.pbmm2.bam` or `*.CHM13-T2T.pbmm2.bam`.
   ```bash
   # Give the script execution permissions
   chmod +x [Reference_Genome]_alignment_QC.sh
   # Run the script
   ./[Reference_Genome]_alignment_QC.sh [Sample1].[Reference_Genome].pbmm2.bam [Sample2].[Reference_Genome].pbmm2.bam
   ```
*** 

### The scripts will: 
- Align reads to  the selected reference genome (GRCh38 or CHM13-T2T) using pbmm2
- Calculate coverage statistics with mosdepth and generate coverage distribution plots
- Generate a consensus sequence from the aligned reads using samtools
- Evaluate the consensus sequence with assembly-stats and QUAST
- Align the consensus sequence back to the reference genome using minimap2 to obtain a paf file
- Generate a coverage plot of the paf file with pafr
- Generate a dot plot of the paf file using dotPlotly
*** 
