# A. pullulans pangenome project

Project overview: This repository contains scripts used to build a pangenome graph of A. pullulans populations. The majority of the data is derived from BioProject: PRJNA488010. 

Workflow
  1. Download data
  2. Quality control raw data
  3. Kmer analysis
  4. Assemble genomes
  5. Quality control assembly
  6. Genome alignment and pangenome graph build

Directory structure 
.
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

