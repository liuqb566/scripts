#!/bin/bash

dic="/home/liuqibao/workspace/snp-calling/gatk-space"
bam_list="/home/liuqibao/workspace/snp-calling/gatk-space/bam_list.txt"
samtools="/home/liuqibao/tools/bin/samtools-1.6"

(cat $bam_list ||exit 0)|while read id
do
echo $dic'/'$id
nohup $samtools index ${dic}/${id} &
done
