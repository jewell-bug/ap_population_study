#!/bin/bash
#SBATCH --job-name=summary
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 1
#SBATCH --mem=10G
#SBATCH --qos=general
#SBATCH --partition=general

#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err


module load bcftools

INDIR=../../results/05_variantCalling/bcftools/raw.vcf.gz
OUTDIR=../../results/05_variantCalling/bcftools_summary

mkdir -p "$OUTDIR"
# Generate variant statistics from VCF
bcftools stats "$INDIR" | grep "SN" > "$OUTDIR/summary.txt"
# Generate filtered statistics excluding low-quality variants (QUAL < 30)
bcftools stats -e "QUAL < 30" "$INDIR" | grep "SN" >> "$OUTDIR/summary.txt"
