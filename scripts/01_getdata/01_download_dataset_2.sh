#!/bin/bash
#SBATCH --job-name=get_genome
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 1
#SBATCH --mem=2G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=xpa24001@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

echo "Running on:"
hostname
date

module load datasets/16.13.0

export NCBI_DATASETS_MAX_REQUESTS=1
export NCBI_DATASETS_RETRY_COUNT=10
export NCBI_DATASETS_RETRY_DELAY=120

#datasets download genome taxon "Aureobasidium pullulans" \
#  --assembly-level complete,chromosome,scaffold \
#  --include genome,seq-report \
#  --no-progressbar \
#  --filename apullulans_genomes.zip

datasets download genome PRJNA488010 \
  --filename apullulans_plus50sample_bioprojects.zip

date

