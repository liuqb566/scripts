#!/bin/bash

#注意都用绝对路径
#gatk：GenomeAnalysisTK.jar
#tmpdir：临时文件目录。最好指定一个；如果默认目录太小，在并行运算的时候会报错, 可能会导致程序终止。
#regeneme：参考基因组文件。同文件夹下要有 .dic 和 .fai 文件
#bam_list：需要运行的 bam 文件列表，每行一个；注意计算好同时运行多少个，以免系统崩溃。bam 文件需要加RG，按cocordination排序，构建索引(格式：name.bam.bai)
#bam_dir：bam 文件和其索引文件的文件夹
#####################################
#2017-11-28	V3	Gossie      #
####################################

# gatk 程序绝对路径
gatk="/home/liuqibao/tools/program/GenomeAnalysisTK-3.8-0-ge9d806836/GenomeAnalysisTK.jar"
# 临时文件夹（绝对路径）
tmpdir="/home/liuqibao/workspace/snp-calling/gatk-space/tmp/"
# 参考基因组（绝对路径）
refgenome="/home/liuqibao/workspace/database/Gossypium_hirsutum_v1.1_replace.fa"
# bam 文件（绝对路径）
bam_dir="/home/liuqibao/workspace/snp-calling/gatk-space/bam_RG_sorted"
# bam 文件列表（绝对路径）
bam_list="/home/liuqibao/workspace/snp-calling/gatk-space/bam_202_281.txt"

(cat $bam_list ||exit 0)|while read id
do
sample=${id%%.*} ||exit 0
echo $sample

mkdir ${tmpdir}/${sample} ||exit 0
nohup \
java -Djava.io.tmpdir=${tmpdir}/${sample} -jar ${gatk} \
-T HaplotypeCaller \
-ERC GVCF \
-R ${refgenome} \
-I ${bam_dir}/${id} \
-o ${sample}_rawLikelihoods.g.vcf \
1>${sample}.gvcf.log 2>&1 \
&& rm -r ${tmpdir}/${sample} \
&
done
