#!/bin/bash 
#SBATCH --job-name=bcf
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

# load required software
#module load freebayes/1.3.4
module load htslib/1.16
module load bcftools
module load samtools
# directories/files

INDIR=../../results/03_Alignment/bwa_align/
BAMDIR=../../results/03_Alignment/bwa_align6
OUTDIR=../../results/05_variantCalling/bcftools
mkdir -p ${OUTDIR} 

# make a list of bam files

# set a variable for the reference genome location
GEN=../../genome/GCF_000721785.1_Aureobasidium_pullulans_var._pullulans_EXF-150_assembly_version_1.0_genomic.fna


mkdir -p $OUTDIR

bcftools mpileup \
-f ../../genome/GCF_000721785.1_Aureobasidium_pullulans_var._pullulans_EXF-150_assembly_version_1.0_genomic.fna \
../../results/03_Alignment/bwa_align6/*.bam \
| bcftools call -mv -Oz -o ${OUTDIR}/raw.vcf.gz

tabix -p vcf ${OUTDIR}/raw.vcf.gz




# run freebayes
#freebayes \
#-f $GEN \
#--bam-list ${INDIR}/bam_list.txt |
#bgzip -c >${OUTDIR}/freebayes.vcf.gz

#tabix -p vcf ${OUTDIR}/freebayes.vcf.gz

date
