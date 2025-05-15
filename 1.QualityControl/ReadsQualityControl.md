# 1. Quality Control of the Reads 

# Requirements 
- [LongQC](https://github.com/yfukasawa/LongQC) program installed and accessible in your environment
- [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) program installed and accessible in your environment
> If you're using the LAVIS Cluster, load the programs as follows:
  ```bash
  module load anaconda3/2021.05
  module load longqc/1.2.0
  module load fastqc/0.11.3
  ```
*** 

## 1. Set an environment variable for the project 
To simplify navigation and ensure consistency throughout the workflow, we will define an environment variable called PROJECT_DIR pointing to the project's root directory. 
Ensure to replace the text inside the brackets with the absolute path to your project folder.
```bash
export PROJECT_DIR=[full path to the project main directory]
# Example: PROJECT_DIR=/home/adiazc/PacBio-HiFi-Pipeline
```
### 1.1. Make the environmental variable persistent across sessions - Optional
By default, environment variables are only available in the current terminal session. To make PROJECT_DIR persistent across future sessions, add it to your .bashrc file as follows 
> **Note:** Be careful, the .bashrc file is a system configuration file and therefore sensitive to changes; ensure you have the necessary permissions and create a backup before making changes.
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
- Create a directory to place the raw reads
- Convert ubam files to fastq format
- Merge all fastq files into one
- Compress the resulting file (.gz)
*** 
