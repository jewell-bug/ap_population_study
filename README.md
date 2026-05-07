# _A. pullulans_ population genomics project

Project overview: This study uses a population of _A.pullulans_ isolates orginially sequenced by Gostincar et al., _Environmental Microbiology_ (2019). The dataset comprises 50 genomes and is being reanalyzed to perform genome-wide variant calling and structural variant detection. The goal is to characterize genomic variation across isolates and assess patterns of structural variation within the population. 

**Gostinčar C, Turk M, Zajc J, Gunde-Cimerman N. 2019. Fifty Aureobasidium pullulans genomes reveal a recombining polyextremotolerant generalist. Environmental Microbiology 21:3638–3652.**
**BioProject: PRJNA488010**


## Workflow

<p align="center">
  <img width="421" height="501" alt="ISG2 drawio" src="https://github.com/user-attachments/assets/620f7352-acd5-4a70-b01f-c62beb982078" width="80" />
</p>





## Directory structure
```
├── data
│   ├── fastq
│   ├── GCA_004917105.1
│   ├── GCA_004917115.1
│   ├── GCA_004917135.1
│   ├── GCA_004917145.1
│   ├── GCA_004917155.1
│   ├── GCA_004917165.1
│   ├── GCA_004917185.1
│   ├── GCA_004917205.1
│   ├── GCA_004917225.1
│   ├── GCA_004917255.1
│   ├── GCA_004917275.1
│   ├── GCA_004917305.1
│   ├── GCA_004917335.1
│   ├── GCA_004917355.1
│   ├── GCA_004917375.1
│   ├── GCA_004917385.1
│   ├── GCA_004917415.1
│   ├── GCA_004917425.1
│   ├── GCA_004917435.1
│   ├── GCA_004917445.1
│   ├── GCA_004917485.1
│   ├── GCA_004917495.1
│   ├── GCA_004917505.1
│   ├── GCA_004917525.1
│   ├── GCA_004917555.1
│   ├── GCA_004917595.1
│   ├── GCA_004917605.1
│   ├── GCA_004917615.1
│   ├── GCA_004917625.1
│   ├── GCA_004917665.1
│   ├── GCA_004917685.1
│   ├── GCA_004917705.1
│   ├── GCA_004917725.1
│   ├── GCA_004917745.1
│   ├── GCA_004917755.1
│   ├── GCA_004917795.1
│   ├── GCA_004917815.1
│   ├── GCA_004917825.1
│   ├── GCA_004918105.1
│   ├── GCA_004918115.1
│   ├── GCA_004918145.1
│   ├── GCA_004918165.1
│   ├── GCA_004918195.1
│   ├── GCA_004918215.1
│   ├── GCA_004918245.1
│   ├── GCA_004918275.1
│   ├── GCA_004918505.1
│   ├── GCA_004918535.1
│   └── GCA_004918575.1
├── genome
├── metadata
├── results
│   ├── 02_qc
│   ├── 03_Alignment
│   ├── 04_alignQC
│   ├── 05_variantCalling
│   └── 06_Annotate
└── scripts
    ├── 01_getdata
    ├── 02_QC_rawdata
    ├── 03_alignment
    ├── 04_alignQC
    ├── 05_variantCalling
    └── 06_filteringAnnotating
```
