#!/bin/bash
#SBATCH --job-name=LUMPY
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

module purge
module load bcftools/1.20
module load samtools



source ~/miniconda3/etc/profile.d/conda.sh
conda activate lumpy_env

# FORCE tools into PATH for LUMPY
export PATH=$CONDA_PREFIX/bin:$PATH

# LUMPY scripts (your git clone)
export PATH=$PWD/lumpy-sv/scripts:$PATH

which samtools

INDIR=../../results/03_Alignment/bwa_align6/
OUTDIR=/scratch/jjung/final_proj/ap_population_study/results/06_Annotate/lumpy

mkdir -p $OUTDIR

for bam in $INDIR/*.bam; do
    sample=$(basename "$bam" .bam)

    # discordant reads
    samtools view -b -F 1294 "$bam" > "$OUTDIR/${sample}.discordants.bam"

    # split reads
    samtools view -h "$bam" | \
        extractSplitReads_BwaMem -i stdin | \
        samtools view -Sb - > "$OUTDIR/${sample}.splitters.bam"

    # run lumpy
    lumpyexpress \
        -B "$bam" \
        -S "$OUTDIR/${sample}.splitters.bam" \
        -D "$OUTDIR/${sample}.discordants.bam" \
        -o "$OUTDIR/${sample}.lumpy.vcf"
done
