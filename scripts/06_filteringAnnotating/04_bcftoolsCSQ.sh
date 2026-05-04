#!/bin/bash
#SBATCH --job-name=bcftoolsCSQ
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
module load bcftools/1.20

# make a directory if it doesn't exist
INDIR=../../results/05_variantCalling/bcftools/
OUTDIR=../../results/06_Annotate/bcftoolsCSQ
mkdir -p ${OUTDIR}

GENOME=../../genome/GCF_000721785.1_Aureobasidium_pullulans_var._pullulans_EXF-150_assembly_version_1.0_genomic.fna
VCFIN=../../results/05_variantCalling/bcftools/bcftools_filtered.vcf.gz
VCFOUT=${OUTDIR}/bcftools_annotated.vcf.gz

# first we need to download and fix up the GFF3 file. bcftools csq only works with ensembl GFF3 files (per the docs)
    # https://samtools.github.io/bcftools/howtos/csq-calling.html
#####https://fungi.ensembl.org/Aureobasidium_pullulans_exf_150_gca_000721785/Info/Index
#wget -P ${OUTDIR} https://ftp.ensemblgenomes.ebi.ac.uk/pub/fungi/release-62/gff3/fungi_ascomycota1_collection/aureobasidium_pullulans_exf_150_gca_000721785/Aureobasidium_pullulans_exf_150_gca_000721785.Aureobasidium_pullulans_var._pullulans_EXF-150_assembly_version_1.0.62.gff3.gz
#gunzip ${OUTDIR}/Aureobasidium_pullulans_exf_150_gca_000721785.Aureobasidium_pullulans_var._pullulans_EXF-150_assembly_version_1.0.62.gff3

GFF=../../genome/genomic.gff


# run bcftools csq
bcftools csq --phase a -f ${GENOME} -g ${GFF} ${VCFIN} -Oz -o ${VCFOUT}
