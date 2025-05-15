# 0. Environment Setup 
*** 

# Overview
This guide contains instructions for preparing the environment and organizing raw PacBio HiFi reads for downstream genome analysis. The steps are: setting up the directory structure, retrieving and converting ubam files, and merging Cell reads into a unified FASTQ file.

# Requirements 
- [bamtofastq](https://github.com/jts/bam2fastq) program installed and accessible in your environment
*** 

# Steps
## 1. Set an environment variable for the project 
To simplify navigation and ensure consistency throughout the workflow, we will define an environment variable called PROJECT_DIR pointing to the project's root directory. 
Ensure to replace the text inside the brackets with the absolute path to your project folder.
```bash
export PROJECT_DIR=[full path to the project main directory]
# Example: PROJECT_DIR=/home/adiazc/PacBio-HiFi-Pipeline
```
### Make the environmental variable persistent across sessions - Optional
By default, environment variables are only available in the current terminal session. To make PROJECT_DIR persistent across future sessions, add it to your .bashrc file as follows 
> **Note:** Be careful, the .bashrc file is a system configuration file and therefore sensitive to changes; make sure you have the necessary permissions and create a backup before making changes.
```bash
# Open your .bashrc file in edit mode
nano ~/.bashrc
# Add the export command for the environment variable at the end of the file
export PROJECT_DIR=[full path to the project main directory]
# Save and close the file
# Apply the changes to the system
source ~/.bashrc
# Restart the terminal
```
## 2. Retrieve raw `.bam` Sequencing Files
In this step, we download the raw .bam files directly from the BYU server responsible for the sequencing.
Make sure to replace the text inside the brackets with your actual username, password, and the full URL path to each file.
> **Note:** This step may vary depending on your data storage location and transfer method. If your files were provided through another method, adjust accordingly.
```bash
# Navigate to the reads directory
cd $PROJECT_DIR
# Download raw data (repeat for each sequencing cell file)
wget --user [USER] --password [PASSWORD] https://files.rc.byu.edu/[wholepath] 
```
## 3. Run the Environment_Setup bash script 
Download the Environment_Setup.sh file from the repository and place it into $PROJECT_DIR/reads/. Within that directory, execute the script as follows: 
```bash
# Give the script execution permissions
chmod +x Environment_Setup.sh
# Execute the script
./Environment_Setup.sh
```
The script will: 
- Ensure 







## 4. Convert .bam files to .fastq format
Since PacBio uses unaligned BAM (ubam) files as its native format for storing raw reads, we will convert them to the standard .fastq format to enable compatibility with most downstream analysis tools. 
Ensure to replace the text inside the brackets with the name of the ubam file
```bash
# Converting bam to fastq (repeat for each sequencing cell file)
bam2fastq [filename].bam
```
## 5. Merge all cell files into a single file for raw reads
PacBio sequencers also generate separate read files for each cell. To simplify downstream processing and ensure compatibility with tools, we will merge all FASTQ files into a single file.
```bash
# Merge all FASTQ files into one
cat *.fastq > merged_raw_reads.fastq
# Compress the merged file to save storage space
gzip *fastq
```
## 6. Creating subdirectories for raw cell files (Optional)
In this step, we create one subdirectory per sequencing cell within the `reads/` directory and place all the raw cell reads data into them to maintain an organized file structure and facilitate easier data handling. 
> **Note:** This structure may need to be adapted depending on the sequencing platform used and the number of cells generated during the run.
```bash
# Create a subdirectory for each Sequencing Cell
cd $PROJECT_DIR/reads/
mkdir Cell-1 Cell-2 Cell-3
# Move each cellfile to its corresponding directory (Repeat for Each Cell File)
mv [Cell-1].fastq.gz Cell-1/
mv [Cell-1].bam Cell-1/
```
