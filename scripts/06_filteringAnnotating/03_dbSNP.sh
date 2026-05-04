#!/bin/bash
#SBATCH --job-name=dbSNP
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 1
#SBATCH --mem=8G
#SBATCH --qos=general
#SBATCH --partition=general
#SBATCH --mail-user=
#SBATCH --mail-type=ALL
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err
hostname
date

module load htslib/1.7
module load bcftools/1.6
module load GATK/4.1.3.0

INDIR=../../results/05_variantCalling/bcftools
OUTDIR=../../results/05_variantCalling/population_vcf

mkdir -p ${OUTDIR}

bcftools view -v snps -m2 -M2 ${INDIR}/bcftools_normAP.vcf.gz | \
bcftools view -i 'MAF>0.01 && F_MISSING<0.1' | \
bgzip > ${OUTDIR}/final.vcf.gz

tabix -p vcf ${OUTDIR}/final.vcf.gz
