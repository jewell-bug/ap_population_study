#!/bin/bash 
#SBATCH --job-name=filterVariants
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 7
#SBATCH --mem=10G
#SBATCH --qos=general
#SBATCH --partition=general
#SBATCH --mail-user=
#SBATCH --mail-type=ALL
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date

module load bcftools/1.16
module load htslib/1.16
module load bedtools/2.29.0

# VCF files
BCFTOOLS=../../results/05_variantCalling/bcftools/raw.vcf.gz
BCFTOOLSOUT=../../results/05_variantCalling/bcftools/bcftools_filtered.vcf.gz



# bcftools: use DP/QUAL (others not available)
bcftools filter \
  --exclude 'QUAL < 30' \
  ${BCFTOOLS} |
bgzip >${BCFTOOLSOUT}

tabix -p vcf ${BCFTOOLSOUT}
