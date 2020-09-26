#! /bin/bash
history：
	2017-4-3 gossie releas 1	

# 以下脚本用于收集每个样本的比对信息
while read id
do
file=$(basename $id)
sample=${file%%.*}
echo $id $sample
stringtie -p 40 -G ~/genome/index/NBI_Gossypium_hirsutum_v1.1.gene.gff3 -o ${sample}.stringtie.gtf -l $sample $id 2>${sample}.strg.log
done < $1 

#若仅关注基因的表达量差异，可以只做到上一步；建议加上 `-e` 参数，因为这个参数可以限制程序只统计与参考基因重叠的比对信息；若想用 ballwgon 做差异分析，可以加 `-B` 参数，生成 ballwgon 的文件。


