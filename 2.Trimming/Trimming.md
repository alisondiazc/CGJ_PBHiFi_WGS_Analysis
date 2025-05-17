# 2. Trimming of Reads 

## Requirements 
- [HiFiAdapterFilt](https://github.com/sheinasim-USDA/HiFiAdapterFilt) v.2.0.0 or later installed and accessible in your environment
- [blast+](https://github.com/ncbi/blast_plus_docs) v.2.13.0 or later installed and accessible in your environment
- [bamtools](https://github.com/pezmaster31/bamtools) v.2.5.1 or later installed and accessible in your environment
> If you're using the LAVIS Cluster, load the programs as follows:
  ```bash
module load hifiadapterfilt/2.0.0
module load blast+/2.13.0
module load bamtools/2.5.1
  ```
*** 

> **Note:** Before running this step, make sure the environment variable PROJECT_DIR is properly defined. To verify that it is set correctly, you can run:  
```bash
echo $PROJECT_DIR
```
> If the output shows the correct path, you're ready to proceed. If it returns nothing, you'll need to export it again or check your shell configuration. Refer to step 0 for detailed instructions. 
*** 

## 1. Download Trimming.sh bash script
Download the Trimming.sh file from the repository and place it into $PROJECT_DIR/

## 2. OPTIONAL - Set up HiFiAdapterFilt arguments
Open the Trimming.sh file and update the following arguments in the "Run HiFiAdapterFilt section" if needed. Make sure to save the file before closing it.
- `-l`: minimum length of adapter match to remove  
- `-m`: minimum percent match of adapter to remove  
- `-t`: number of threads

## 3. Run Trimming.sh bash script
Before running the script, make sure to replace the text inside the brackets with your sample name(s). The script supports multiple samples, but each input file must follow the naming format of *_merged_reads.fastq 
```bash
# Give the script execution permissions
chmod +x Trimming.sh
# Execute the script
./Trimming.sh [Sample1]_merged_reads.fastq [Sample2]_merged_reads.fastq
```
### The script will: 
- Create directories to place HiFiAdapterFilt output files
- Run HiFiAdapterFilt with 
*** 

