# 0. Environment Setup 
*** 

## Overview
Steps to follow in order to prepare the environment and organize the raw PacBio HiFi reads for downstream analysis. 
It includes instructions for creating directory structures, downloading and converting `.bam` to `.fastq`, and merging the resulting reads into a single file.

### Requirements 
- [bamtofastq](https://github.com/jts/bam2fastq) program installed and accessible in your environment
*** 

## 1. Create a directory for raw reads
In this step, we create a main directory (`reads/`) containing one subdirectory per sequencing cell. 
This structure reflects the output format of the PacBio Sequel IIe system, which generates a separate file for each cell.
> **Note:** This structure may need to be adapted depending on the sequencing platform used and the number of cells generated during the run.
```bash
# Create the main directory
mkdir reads/
# Create a subdirectory for each Sequencing Cell
cd reads/
mkdir Cell-1 Cell-2 Cell-3
```
## 2. Retrieve raw `.bam` Sequencing Files
In this example, we download the raw `.bam` files directly from the BYU server, which performed the sequencing. 
Ensure to complete the command with your user, password, and the whole path to where the files are stored. 
> **Note:** You may need to adjust this step depending on your setup's appropriate storage location and transfer method.
```bash
# Navigate to the main directory
cd reads/
# Download raw data (Repeat for Each Cell File)
wget --user [USER] --password [PASSWORD] https://files.rc.byu.edu/[wholepath] .
```
## 3. Convert .bam files to .fastq format
Since PacBio uses unaligned BAM (uBAM) files as its native format for read storage, it is necessary to convert them to fastq format to enable compatibility with downstream analysis tools. 
Ensure to complete the filename with your own .bam file
```bash
# Converting bam to fastq (Repeat for Each Cell File)
bam2fastq [filename].bam
```
## 4. Merge all cell files into a single file for raw reads
Since PacBio sequencers output separate files for each cell, it is necessary to merge them to ensure compatibility with downstream analysis tools.
```bash
cat *.fastq > merged_raw_reads.fastq
# Zip all fastq files
gzip *fastq
```
## 5. Creating subdirectories for raw cell files (Optional)
In this step, we create one subdirectory per sequencing cell within the `reads/` directory and place all the raw cell reads data into them to maintain an organized file structure and facilitate easier data handling. 
> **Note:** This structure may need to be adapted depending on the sequencing platform used and the number of cells generated during the run.
```bash
# Create a subdirectory for each Sequencing Cell
cd reads/
mkdir Cell-1 Cell-2 Cell-3
# Move each cellfile to its corresponding directory (Repeat for Each Cell File)
mv [Cell-1].fastq.gz Cell-1/
mv [Cell-1].bam Cell-1/
```
