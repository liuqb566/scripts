#! /bin/bash
# 本脚本用于将 hisat2 产生的 sam 文件转换成 bam 文件,同时对 bam 文件排序。
# 本脚本用到的 samtools 是 1.4 版，可以在转换 bam 的同时对 bam 文件进行排序；老版本请先转换再排序。
# 本脚本需要一个样本 sam 的列表文件
# history：
#	2017-4-2 gossie Releas 1

while read id
do
file=$(basename $id)
sample=${file%%.*}
echo $id $sample 
samtools1.4 sort -@ 50 -o ${sample}.sorted.bam $id 
done < $1
