#!/bin/bash
# 本脚本是 StringTie 分析的第二步和第三步，需用于 StringTie 收集各个样本的比对信息之后（第一步），进行转录本的整合和重新收集比对信息，目的是跟据不同样的比对信息重组成完整的转录本，以发现新的异构体。

# 第二步，合并所有样本的比对信息，重构转录本，merge.list 为所有样本 gtf 文件的列表。
stringtie --merge -p 50 -G ~/genome/index/NBI_Gossypium_hirsutum_v1.1.gene.gff3 -o stringtie_merge.gtf mergelist.txt

# 第三步，重新比对，与第一步算法一样，$2 为第二获得的整合文件,输出文件在 ballgown 文件夹下，每个样本单独一个文件夹
while read id
do
file=$(basename $id)
sample=${file%%.*}
echo $id $sample
stringtie -e -B -G $2 -o ballgown/$sample/$sample.strg.gtf $id
done <$1
