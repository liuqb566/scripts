#!/bin/bash
# 本脚本用来计算比对的 reads 数。
# history:
	2017-4-3 gossie releas 1

while read id
do 
file=$(basename $id)
sample=${file%%.*}
echo $id $sample
htseq-count -f bam -s no -i ID $id /home/zmsbio/weihengling/genome/index/NBI_Gossypium_hirsutum_v1.1.gene.gff3 1>$sample.htseqCounts 2>$sample.htseq.log
done <$1
# -f:指定输入文件格式,bam/sam,无论哪种格式都需要经过排序
# -s:是否有链特异性,yes/no,默认 yes,但一般 no.
# -i:参考文件第 9 列, gtf 格式为 gene_id,gff 格式为 ID,默认为 gene_id,若用 gff 格式,需要设为 ID.
# bam/sam 文件在前,gtf/gff 注释文件在后.
