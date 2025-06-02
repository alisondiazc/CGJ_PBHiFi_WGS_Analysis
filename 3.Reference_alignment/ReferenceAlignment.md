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
- [mosdepth](https://github.com/brentp/mosdepth) script plot-dist.py accessible in your environment
- [dotPlotly](https://github.com/tpoorten/dotPlotly) script pafCoordsDotPlotly.R accessible in your environment
- [QUAST](https://quast.sourceforge.net/) script quast.py accessible in your environment
- pafr_plotting.R script (included in this repository) accessible in your environment
> Once downloaded, you will need to change the permissions of the files as follows:
  ```bash
chmod 777 plot-dist.py
chmod 777 pafCoordsDotPlotly.R
chmod 777 quast.py
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

1. Download the appropriate script based on the reference genome you plan to use, and place it inside your `$PROJECT_DIR/` directory:
   - `GRCh38_alignment.sh` — for aligning reads to the GRCh38 reference genome  
   - `CHM13-T2T_alignment.sh` — for aligning reads to the CHM13-T2T reference genome

2. Configure the script by editing the variables listed in the **"Environment set-up"** and **"# Reads alignment with pbmm2"** sections:
   - `REF_FASTA`: Full path to the reference genome FASTA file  
     > **Note:** The corresponding index file (`.fai`) must be located in the same directory as the FASTA file.
   - `-j`: Number of threads to use during alignment

3. Run the script. You can provide one or multiple input files. Each file must follow the naming convention `*_merged_reads.fastq`.

   ```bash
   # Give the script execution permissions
   chmod +x [Reference_Genome]_alignment.sh

   # Run the script
   ./[Reference_Genome]_alignment.sh [Sample1].fastq [Sample2].fastq














### 1. Read alignment against a reference genome (GRCh38/CHM13-T2T)
1.1. Download the corresponding script from the repository, depending on which reference genome you intend to align the reads to, and place it in the $PROJECT_DIR/ directory
  - `GRCh38_alignment.sh` for read alignment against GRCh38 reference genome
  - `CHM13-T2T_alignment.sh` for read aligment against CHM13-T2T reference genome
1.2. Set up the script variables and arguments listed in the "Environment set-up" and "# Reads alignment with pbmm2" sections
  - `REF_FASTA`: path to the reference genome fasta file - Note: The index file (*.fai) has to be in the same directory as this file
  - `-j`: number of threads
1.3. Run the script as follows, ensuring to replace the text inside the brackets with your sample or genome reference name(s). Note: The script supports multiple samples, but each input file must follow the naming format of *_merged_reads.fastq
```bash
# Give the script execution permissions
chmod +x [Reference_Genome]_alignment.sh
# Execute the script
./[Reference_Genome]_alignment.sh [Sample1].fastq [Sample2].fastq
```
Note: the script can be run with the raw or trimmed read files (.fastq) depending of the quality of the reads. 

### 2. Quality Control of the obtained genome alignment 






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
