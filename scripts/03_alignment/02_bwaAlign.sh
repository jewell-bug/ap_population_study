#!/bin/bash 
#SBATCH --job-name=align_pipe
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 8
#SBATCH --mem=30G
#SBATCH --qos=general
#SBATCH --partition=xeon
#SBATCH --mail-user=
#SBATCH --mail-type=ALL
#SBATCH -o %x_%A_%a.out
#SBATCH -e %x_%A_%a.err
#SBATCH --array=[0-53]

hostname
date

module load samtools/1.16.1
module load samblaster/0.1.24
module load bwa-mem2/2.1

#set directories
SAMPDIR=../../results/02_qc/trimmed_fastq2

OUTDIR=../../results/03_Alignment/bwa_align6
mkdir -p $OUTDIR

INDEX=../../results/03_Alignment/bwa_index/APEXF



# sample ID list
SAMPLELIST=(
SRR7958549
SRR7958550
SRR7958551
SRR7958552
SRR7958553
SRR7958554
SRR7958555
SRR7958556
SRR7958557
SRR7958558
SRR7958559
SRR7958560
SRR7958561
SRR7958562
SRR7958563
SRR7958564
SRR7958565
SRR7958566
SRR7958567
SRR7958568
SRR7958569
SRR7958570
SRR7958571
SRR7958572
SRR7958573
SRR7958574
SRR7958575
SRR7958576
SRR7958577
SRR7958578
SRR7958579
SRR7958580
SRR7958581
SRR7958582
SRR7958583
SRR7958584
SRR7958585
SRR7958586
SRR7958587
SRR7958588
SRR7958589
SRR7958590
SRR7958591
SRR7958592
SRR7958593
SRR7958594
SRR7958595
SRR7958596
SRR7958597
SRR7958598
SRR7958599
SRR7958600
SRR7958601)


# extract one sample ID
SAMPLE=${SAMPLELIST[$SLURM_ARRAY_TASK_ID]}
echo ${#SAMPLELIST[@]}
echo "Processing sample: $SAMPLE"

# create read group string
RG=$(echo \@RG\\tID:$SAMPLE\\tSM:$SAMPLE)
echo "Read Group:"
echo -e "${RG}"

echo "bwa-mem2 mem -t 7 -R '${RG}' ${INDEX} \\"
echo "  ${SAMPDIR}/${SAMPLE}_trim_1.fastq.gz \\"
echo "  ${SAMPDIR}/${SAMPLE}_trim_2.fastq.gz"


bwa-mem2 mem -t 7 -R ${RG} ${INDEX} ${SAMPDIR}/${SAMPLE}_trim_1.fastq.gz $SAMPDIR/${SAMPLE}_trim_2.fastq.gz | \
	samblaster | \
	samtools view -u - | \
	samtools sort -T ${OUTDIR}/${SAMPLE}.temp -O BAM >$OUTDIR/${SAMPLE}.bam 

# index alignment file
samtools index ${OUTDIR}/${SAMPLE}.bam

