#! /bin/bash
<<<<<<< HEAD
# 输入文件：sra id
#index文件
index=/home/liuqb/data/genome/Cotton/HAU1.0/hisat2/HAU_genome
while read id
do
#--dta 输出比对情况
hisat2 -p 8 --dta -x $index -1 ${id}_1P.fastq.gz -2 ${id}_2P.fastq.gz -S $id.hisat2.sam >$id.hisat2.log 2>&1 && samtools sort -@ 10 -o $id.sorted.bam $id.hisat2.sam && rm $id.hisat2.sam 
done < $1 
=======
# 该脚本需要一个 3 列的文件，格式如下：
# sample read1 read2

while read id
do
sample=$(echo $id | cut -d" " -f1)
file1=$(echo $id | cut -d" " -f2)
file2=$(echo $id | cut -d" " -f3)
echo $sample
echo $file1
echo $file2
hisat2 -p 8 --dta -x ~/genome/index_hisat2/NAU_tran -1 ../$file1 -2 ../$file2 -S $sample.hisat2.sam 2>$sample.hisat2.log &
done < $1 

# --dta:有助于提高计算性能和内存使用
# --dta-cufflinks:可输出直接用于 Cufflinks（包括 Cuffmerge，Cuffdiff）的文件。
>>>>>>> ce752dede0d945ae2e8e2c9a19902f899e223fdb
