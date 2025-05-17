# 1. Quality Control of the Reads 

# Requirements 
- [LongQC](https://github.com/yfukasawa/LongQC) v.1.2.0 program installed and accessible in your environment
- [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) v.0.11.3 program installed and accessible in your environment
> If you're using the LAVIS Cluster, load the programs as follows:
  ```bash
  module load anaconda3/2021.05
  module load longqc/1.2.0
  module load fastqc/0.11.3
  ```
*** 

> **Note:** Before running this step, make sure the environment variable PROJECT_DIR is properly defined. To verify that it is set correctly, you can run:  
```bash
echo $PROJECT_DIR
```
> If the output shows the correct path, you're ready to proceed. If it returns nothing, you'll need to export it again or check your shell configuration.
*** 

## 1. Download Reads_QC.sh bash script
Download the Reads_QC.sh file from the repository and place it into $PROJECT_DIR/

## 2. OPTIONAL - Set up Reads_QC.sh variables
Open the Environment_Setup.sh file and update the following variables if needed:
- LONGQC: Full path to the longQC.py script
- THREADS: Number of cores used for the analysis
Make sure to save the file before closing it.

## 3. Run Reads_QC.sh bash script
Before running the script, make sure to replace the text inside the brackets with your sample name(s). The script supports multiple samples, but each input file must follow the naming format of *_merged_reads.fastq 
```bash
# Give the script execution permissions
chmod +x Reads_QC.sh
# Execute the script
./Reads_QC.sh [Sample1]_merged_reads.fastq [Sample2]_merged_reads.fastq
```

### The script will: 
- Create directories to place LongQC & FastQC output files
- Run LongQC with the pb-hifi preset
- Run FastQC
*** 
