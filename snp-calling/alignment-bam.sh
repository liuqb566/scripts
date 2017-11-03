#! /bin/bash

for i in  `ls ~/SLAF-seq/data/raw-data/`
do
sra=$(echo $i|cut -c 1-10)
echo $sra
#Decompresison of sra one by one
fastq-dump --split-3 -O fastq-data/ ~/SLAF-seq/data/raw-data/$i || exit 0
ls fastq-data
bwa-0.7.15 mem -t 40 NAU_v1.1_replace_chr ./fastq-data/${sra}_1.fastq ./fastq-data/${sra}_2.fastq >${sra}.sam && ls -lh ${sra}.sam || exit 0
samtools view -Sb -o ${sra}.bam ${sra}.sam ||exit 0
rm ${sra}.sam
rm ./fastq-data/*
done
