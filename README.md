# A. pullulans pangenome project

Project overview: This repository contains scripts used to build a pangenome graph of A. pullulans populations. The majority of the data is derived from BioProject: PRJNA488010. 

Workflow
  1. Download data
  2. Quality control raw data
  3. Kmer analysis
  4. Assemble genomes
  5. Quality control assembly
  6. Genome alignment and pangenome graph build

<pre> ## Project Structure ```bash ap_population_study/ ├── data/ │ ├── raw/ │ └── processed/ ├── results/ │ ├── figures/ │ └── tables/ ├── scripts/ │ ├── preprocessing/ │ ├── analysis/ │ └── plotting/ └── README.md ``` </pre>
