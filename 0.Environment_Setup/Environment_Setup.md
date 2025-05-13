# 0. Environment Setup 
*** 

## Overview
Steps to follow in order to prepare the environment and organize the raw PacBio HiFi reads for downstream analysis. 
It includes instructions for creating directory structures, downloading and converting `.bam` to `.fastq`, and merging the resulting reads into a single file.

### Requirements 
- [bamtofastq](https://github.com/jts/bam2fastq) program installed and accessible in your environment
*** 

## 1. Create directory structure for raw reads
In this step, we create a main directory (`reads/`) containing one subdirectory per sequencing cell. 
This structure reflects the output format of the PacBio Sequel IIe system, which generates a separate file for each cell.
> **Note:** This structure may need to be adapted depending on the sequencing platform used and the number of cells generated during the run.
```bash
# Create the main directory
mkdir reads
# Create a subdirectory for each Sequencing Cell
cd reads
mkdir Cell-1 Cell-2 Cell-3
```
## 2. Retrieve raw `.bam` Sequencing Files
In this example, we download the raw `.bam` files directly from the BYU server, which performed the sequencing. You need to complete the command with your user, password, and whole path to where the files are stored. 
> **Note:** You may need to adjust this step depending on your setup's appropriate storage location and transfer method.
```bash
# Navigate to the main directory
cd reads
# Download raw data
wget --user [USER] --password [PASSWORD] https://files.rc.byu.edu/[wholepath] .
```
## 3. 

## 2. Populate Cell Directories with Sequencing Data
We will need to place each raw 
