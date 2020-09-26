#!/bin/bash
#HTseq 0.12版本需要python3.6以上

#GFF文件
GFF='/home/liuqb/data/genome/Cotton/HAU1.0/HAU.gene.gtf'
#排序方式：name/pos
Order='pos'
#第9列格式，GTF：gene_id;GFF: ID；默认gene_id
F9='gene_id'
# feathue type，默认exon
type='exon'
#线程
n='40'

while read id
do 
#nohup htseq-count -f bam -r ${Order} -s no -i ID -t ${type} ${id}.sorted.bam ${GFF} >${id}.htseqCounts 2>${id}.htseqlog & 
nohup htseq-count -f bam -r ${Order} -s no -n ${n} ${id}.sorted.bam ${GFF} >${id}.htseqCounts 2>${id}.htseqlog &
done <$1
# -f:指定输入文件格式,bam/sam,无论哪种格式都需要经过排序
# -r:bam文件排序方式，默认read name;注意，samtools的排序方式默认为position
# -s:是否有链特异性,yes/no,默认 yes,但一般 no.
# -i:参考文件第 9 列, gtf 格式为 gene_id,gff 格式为 ID,默认为 gene_id,若用 gff 格式,需要设为 ID.
# -t:统计feathure type；GTF的第三行,默认exon
# bam/sam 文件在前,gtf/gff 注释文件在后.

