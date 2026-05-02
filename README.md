# _A. pullulans_ population genomics project

Project overview: This study uses a population of _A.pullulans_ isolates orginially sequenced by Gostincar et al., _Environmental Microbiology_ (2019). The dataset comprises 50 genomes and is being reanalyzed to perform genome-wide variant calling and structural variant detection. The goal is to characterize genomic variation across isolates and assess patterns of structural variation within the population. 

BioProject PRJNA488010

## Workflow
```
  1. Download data
  2. Quality control raw data
    - FastQC
    - MultiQC
  3. Kmer analysis
    - Meryl count
    - GenomeScope
  4. Assemble genomes
  5. Quality control assembly
    - FastQC
    - MultiQC
    - Busco
  6. Genome alignment and pangenome graph build
    - pggb
```
```.
Directory structure
├── data
├── README.md
├── results
└── scripts
    ├── 01_getdata
    │   └── 01_download_dataset_2.sh
    ├── 02_QC_rawdata
    ├── 03_kmer_analysis
    ├── 04_genome_assembly
    └── 05_pangenome_analysis
```
