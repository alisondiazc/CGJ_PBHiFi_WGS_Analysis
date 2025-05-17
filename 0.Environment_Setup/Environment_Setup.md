# 0. Environment Setup 

# Requirements 
- [bamtofastq](https://github.com/jts/bam2fastq) program installed and accessible in your environment -> ***Only required if using Step 3***
*** 

## 1. Set an environment variable for the project 
To simplify navigation and ensure consistency throughout the workflow, we will define an environment variable called PROJECT_DIR pointing to the project's root directory. 
Ensure to replace the text inside the brackets with the absolute path to your project folder.
```bash
export PROJECT_DIR=[full path to the project main directory]
# Example: PROJECT_DIR=/home/adiazc/PacBio-HiFi-Pipeline
```
### 1.1. OPTIONAL - Make the environmental variable persistent across sessions 
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
## 3. Preprocessing of unmerged raw reads (Only for unmerged uBAM files from individual sequencing cells)
If the sequencing reads were provided as unaligned BAM (uBAM) files, PacBio’s native format for storing reads, you’ll need to convert and merge them into a single FASTQ file to ensure compatibility with downstream analysis tools as follows: 
1. Download the preprocess_cellreads.sh script from the repository and place it inside your $PROJECT_DIR/.
2. Edit the script by opening preprocess_cellreads.sh and updating the SAMPLE_NAME variable with your sample name. Be sure to save the file before closing it.
3. Make the script executable and run it:
```bash
# Grant execution permissions
chmod +x preprocess_cellreads.sh
# Run the script
./preprocess_cellreads.sh
```
### The script will: 
- Create a directory to place the unmerged raw reads
- Convert ubam files to fastq format
- Merge all fastq files into one
- Compress the resulting file (.gz)
*** 





