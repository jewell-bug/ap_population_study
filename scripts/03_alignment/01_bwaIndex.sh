#!/bin/bash 
#SBATCH --job-name=bwa_index
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 8
#SBATCH --mem=10G
#SBATCH --qos=general
#SBATCH --partition=xeon
#SBATCH --mail-user=
#SBATCH --mail-type=ALL
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date

# load required software
module load bwa-mem2/2.1

# set directories
INDEXDIR=../../results/03_Alignment/bwa_index
mkdir -p $INDEXDIR

GENOME=../../genome/GCF_000721785.1_Aureobasidium_pullulans_var._pullulans_EXF-150_assembly_version_1.0_genomic.fna


# Create index for genome
    # requires significant memory for indexing
bwa-mem2 index \
   -p $INDEXDIR/APEXF2 \
   $GENOME
