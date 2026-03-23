# 4. De novo assembly of PacBio HiFi reads
*** 

## Requirements
### Genome Alignment Process
- [hifiasm](https://github.com/chhylp123/hifiasm) v.0.16.1 or later installed and accessible in your environment



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
module load hifiasm/0.16.1
module load miniconda/4.3.1
module load r/4.0.2
module load python38/3.8.3
module load mosdepth/0.3.3
module load samtools/1.16.1
module load assembly-stats/1.0.1
module load minimap2/2.24
  ```
