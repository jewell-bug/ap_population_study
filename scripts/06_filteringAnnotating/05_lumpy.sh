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


which samtools
INDIR=../../results/03_Alignment/bwa_align6/
OUTDIR=/scratch/jjung/final_proj/ap_population_study/results/06_Annotate/lumpy2

mkdir -p $OUTDIR

for bam in $INDIR/*.bam; do
    sample=$(basename "$bam" .bam)

# discordant reads
    samtools view -b -F 1294 "$bam" > "$OUTDIR/${sample}.discordants.bam"

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

#sumary sv
for vcf in $OUTDIR/*.vcf
do
    sample=$(basename $vcf .vcf)

    dels=$(grep "SVTYPE=DEL" $vcf | wc -l)
    dups=$(grep "SVTYPE=DUP" $vcf | wc -l)
    invs=$(grep "SVTYPE=INV" $vcf | wc -l)

    echo -e "$sample\t$dels\t$dups\t$invs"
done > ${OUTDIR}/sv_counts.txt

#isolate deletions
bcftools view -i 'INFO/SVTYPE="DEL"' ${OUTDIR}/SRR7958588.lumpy.vcf -Oz -o ${OUTDIR}/DEL.vcf.gz
bcftools index ${OUTDIR}/DEL.vcf.gz
