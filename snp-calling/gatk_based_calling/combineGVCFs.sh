#!/bin/bash

# GenotypeGVCF 程序运行的 gvcf 文件最好不要超过 200 个（300 也可以，太多就会消耗非常大的内存）。所以如果样本太多，产生了大量的 g.vcf 文件，需要用 CombineGVCFs 程序将适量的 gvcf 文件合并成一个 .g.vcf 文件。
# 需要注意的是 CombineGVCFs 程序也比较耗时。请合理取舍。
# CombineGVCFs 好像不能使用多线程，可行的减少时间的方法是 -L 参数，分别对染色体进行合并。

#注意都用绝对路径
#gatk：GenomeAnalysisTK.jar
#tmpdir：临时文件目录。最好指定一个；如果默认目录太小，在并行运算的时候会报错, 可能会导致程序终止。
#regeneme：参考基因组文件。同文件夹下要有 .dic 和 .fai 文件
#####################################
#2017-12-14	V1	Gossie      #
####################################

# gatk 程序绝对路径
gatk="/home/liuqibao/tools/program/GenomeAnalysisTK-3.8-0-ge9d806836/GenomeAnalysisTK.jar"
# 临时文件夹（绝对路径）
tmpdir="/home/liuqibao/workspace/snp-calling/gatk-space/tmp/"
# 参考基因组（绝对路径）
refgenome="/home/liuqibao/workspace/database/Gossypium_hirsutum_v1.1_replace.fa"
# gvcf 文件列表，必须用 .list 后缀
gvcf="cohort_1_100.list"
# 输出文件前缀
output="cohort"

java -Djava.io.tmpdir=${tmpdir} -jar ${gatk} \
-T CombineGVCFs \
-R ${refgenome} \
--variant ${gvcf} \
-o ${output}_g.vcf 
#1>cohort_1_100.log 2>&1 \
