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
- [QUAST](https://quast.sourceforge.net/) script quast.py accessible in your environment
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
- [mosdepth](https://github.com/brentp/mosdepth) script plot-dist.py accessible in your environment
- [dotPlotly](https://github.com/tpoorten/dotPlotly) script pafCoordsDotPlotly.R accessible in your environment
> Once downloaded, you will need to change the permissions of the files as follows:
  ```bash
chmod 777 plot-dist.py
chmod 777 pafCoordsDotPlotly.R
  ```
*** 

## Instructions
> **Note:** Before proceeding with the following steps, ensure that the PROJECT_DIR environment variable is properly defined. To verify that it is set correctly, you can run:  
```bash
echo $PROJECT_DIR
```
> If the output shows the correct path, you're ready to proceed. If it returns nothing, you'll need to export it again or check your shell configuration. Refer to step 0 for detailed instructions. 

### 1. Download GRCh38_alignment.sh or CHM13_T2T_alignment.sh bash script
Download the corresponding script from the repository depending on which reference genome you intend to align the reads to, and place it in the $PROJECT_DIR/ directory. 

### 2. OPTIONAL - Set up script arguments
Open the Trimming.sh file and update the following arguments in the "Run HiFiAdapterFilt section" if needed. Make sure to save the file before closing it.

### 3. Run GRCh38_alignment.sh or CHM13_T2T_alignment.sh bash script
Before running the respective script, make sure to replace the text inside the brackets with your sample name(s). The script supports multiple samples, but each input file must follow the naming format of *_merged_reads.fastq
*** 

### The script will: 
- Create directories to place LongQC & FastQC output files
- Run LongQC with the pb-hifi preset
- Run FastQC
*** 
