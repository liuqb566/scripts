#! /bin/bash
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
