#! /bin/bash
# 输入文件：sra id
#index文件
index=/home/liuqb/data/genome/Cotton/HAU1.0/hisat2/HAU_genome
while read id
do
#--dta 输出比对情况
hisat2 -p 8 --dta -x $index -1 ${id}_1P.fastq.gz -2 ${id}_2P.fastq.gz -S $id.hisat2.sam >$id.hisat2.log 2>&1 && samtools sort -@ 10 -o $id.sorted.bam $id.hisat2.sam && rm $id.hisat2.sam 
done < $1 
