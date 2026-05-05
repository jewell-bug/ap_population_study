#!/bin/sh
#SBATCH --job-name=fasterq_dump_xanadu
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 7
#SBATCH --mem=15G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=xpa24001@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

export TMPDIR=/tmp
hostname
date



# load software

#parallel - run multiple jobs at once
module load parallel/20180122
module load sratoolkit/3.0.1

# data set from "Fifty Aureobasidium pullulans genomes reveal a recombining polyextremotolerant generalist"


OUTDIR=../../data/fastq
    mkdir -p ${OUTDIR}
METADATA=../../metadata/SraRunTable.txt
#https://www.ncbi.nlm.nih.gov/bioproject/PRJNA488010/
# Get a list of SRA accession numbers to download, put them in a file



# extract rows matching our treatment groups names, pull out the SRA accession number (the first column)
ACCLIST=../../metadata/accessionlist.txt
sed '1d' $METADATA | cut -f 1 -d "," >$ACCLIST

# use parallel to download 2 accessions at a time.
#cat $ACCLIST | parallel --tmpdir /home/FCAM/jjung/ISG/git_ex9/rnaseq_tutorial/scripts/01_rawdata/tmp  -j 2 "fasterq-dump -O ${OUTDIR} {}"

# compress the files
ls ${OUTDIR}/*fastq | parallel -j 6 gzip

##SRA run table was downloaded and filezilla was used to transfer run table and accession list
