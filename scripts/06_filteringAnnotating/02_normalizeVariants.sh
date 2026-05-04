#!/bin/bash 
#SBATCH --job-name=normalizeVariants
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
module load vcflib/1.0.0-rc1


BCFTOOLS=../../results/05_variantCalling/bcftools/bcftools_filtered.vcf.gz
BCFTOOLSOUT=../../results/05_variantCalling/bcftools/bcftools_norm.vcf.gz
BCFTOOLSOUTAP=../../results/05_variantCalling/bcftools/bcftools_normAP.vcf.gz

# genome
GENOME=../../genome/GCF_000721785.1_Aureobasidium_pullulans_var._pullulans_EXF-150_assembly_version_1.0_genomic.fna



# bcftools
bcftools view ${BCFTOOLS} | 
  bcftools norm -f ${GENOME} -O z -o ${BCFTOOLSOUT}

bcftools view ${BCFTOOLS} | 
  bcftools norm -f ${GENOME} |
  vcfallelicprimitives | vcfstreamsort |
  bgzip >${BCFTOOLSOUTAP}
tabix -p vcf ${BCFTOOLSOUTAP}

