#! /bin/bash

# 加表头，同时按 coordinate 排序；ID、LB、PU、SM 都设为样本sra号

dic="/home/liuqibao/workspace/snp-calling/gatk-space/"
bam_list="/home/liuqibao/workspace/snp-calling/gatk-space/bam_list.txt"
(cat ${bam_list} || exit 0)|while read id
do
sra=${id%%.*}
echo $sra
nohup \
java -jar ~/tools/program/picard.jar \
AddOrReplaceReadGroups \
I= ${dic}/${id} \
O=${sra}_RG_sorted.bam \
SORT_ORDER=coordinate \
RGSM=$sra \
RGPU=$sra \
RGID=$sra \
RGLB=$sra \
RGPL=Illumina \
1>${sra}_RG_stored.log 2>&1 \
&
done

