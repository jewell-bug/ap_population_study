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
module load plink/2.00a2.3LM
module load bcftools/1.6

INDIR=../../results/05_variantCalling/bcftools
OUTDIR=../../results/05_variantCalling/population_vcf

mkdir -p ${OUTDIR}

#bcftools view -v snps -m2 -M2 ${INDIR}/bcftools_normAP.vcf.gz | \
#bcftools view -i 'MAF>0.01 && F_MISSING<0.1' | \
#bgzip > ${OUTDIR}/final.vcf.gz

#tabix -p vcf ${OUTDIR}/final.vcf.gz

bcftools query \
  -f '%CHROM\t%POS\t%REF\t%ALT\t%QUAL\t%INFO/DP\n' \
  final.vcf.gz | gzip > final.clean.query.txt.gz


plink2  --vcf ${OUTDIR}/final.vcf.gz \
	--allow-extra-chr \
	--indep-pairwise 50 5 0.2 \
	--out ${OUTDIR}/pruned


plink2 --vcf ${OUTDIR}/final.vcf.gz \
      --allow-extra-chr \
      --extract ${OUTDIR}/pruned.prune.in \
      --make-bed \
      --out ${OUTDIR}/dataset


plink2 --bfile ${OUTDIR}/dataset \
      --allow-extra-chr \
      --pca 10 \
      --out ${OUTDIR}/pca
