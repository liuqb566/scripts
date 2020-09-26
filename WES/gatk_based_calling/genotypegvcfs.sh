#!/bin/bash

# 如果 gvcf 过多，需要先用 CombineGVCFs 程序进行合并，以减少运行内存和时间

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
tmpdir="/home/liuqibao/workspace/snp-calling/gatk-space/tmp2/"
# 参考基因组（绝对路径）
refgenome="/home/liuqibao/workspace/database/Gossypium_hirsutum_v1.1_replace.fa"
# gvcf 文件列表
gvcf="gvcf_all.list"
# 输出文件前缀
output="calling_1"
# 并行运算,仅能用 -nt 参数，合并规划线程和内存
nt=40

java -Djava.io.tmpdir=${tmpdir} -jar ${gatk} \
-T GenotypeGVCFs \
-R ${refgenome} \
-nt ${nt} \
--variant ${gvcf} \
-o ${output}.vcf 
#1>cohort_1_100.log 2>&1 \
