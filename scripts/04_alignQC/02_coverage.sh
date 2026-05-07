<<<<<<< Updated upstream

=======
#!/bin/bash
#SBATCH --job-name=coverage_viz
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 5
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
module load bedtools
module load samtools
module load bamtools
module load htslib   # for bgzip

# input/output
INDIR=../../results/03_Alignment/bwa_align6
OUTDIR=../../results/04_alignQC/coverage
mkdir -p "$OUTDIR"

# reference genome
GENOME=../../genome/GCF_000721785.1_Aureobasidium_pullulans_var._pullulans_EXF-150_assembly_version_1.0_genomic.fna
FAI=${GENOME}.fai

# index genome if needed
if [ ! -f "$FAI" ]; then
    samtools faidx "$GENOME"
fi

# genome file for bedtools
GFILE="$OUTDIR/genome.txt"
cut -f1,2 "$FAI" > "$GFILE"
# 10kb window

WIN10KB="$OUTDIR/genome_10kb.bed"
bedtools makewindows -g "$GFILE" -w 10000 > "$WIN10KB"

# create BAM list
#find "$INDIR" -name "*.bam" > "$OUTDIR/bam.list"

# compute population coverage (clean + smooth)
bamtools merge -list "$OUTDIR/bam.list" | \
bamtools filter -in - -mapQuality ">30" -isDuplicate false -isProperPair true | \
samtools depth -a - | \
awk 'BEGIN{OFS="\t"}{print $1,$2-1,$2,$3}' | \
bedtools map -a "$WIN10KB" -b stdin -c 4 -o mean,median,count | \
bgzip > "$OUTDIR/coverage_10kb.bed.gz"
