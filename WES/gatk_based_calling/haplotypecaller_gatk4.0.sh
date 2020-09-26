#!/bin/bash

#注意都用绝对路径
#gatk4.0: 与gatk3.X 的命令格式发生了变化
#tmpdir：临时文件目录。最好指定一个；如果默认目录太小，在并行运算的时候会报错, 可能会导致程序终止。
#regeneme：参考基因组文件。同文件夹下要有 .dic 和 .fai 文件
#bam_list：需要运行的 bam 文件列表，每行一个；注意计算好同时运行多少个，以免系统崩溃。bam 文件需要加RG，按cocordination排序，构建索引(格式：name.bam.bai)
#bam_dir：bam 文件和其索引文件的文件夹
#####################################
#2018-1-31	V4	Gossie      #
####################################

# gatk 程序绝对路径
gatk="/home/liuqibao/tools/program/gatk-4.0.0.0/gatk"
# 临时文件夹（绝对路径）
tmpdir="/home/liuqibao/workspace/snp-calling/gatk-space/SLAF03/tmp"
# 参考基因组（绝对路径）
refgenome="/home/liuqibao/workspace/database/genome/Gossypium_hirsutum_v1.1_replace_scaffold1000.fa"
# bam 文件（绝对路径）
bam_dir="/home/liuqibao/workspace/snp-calling/gatk-space/SLAF03/data"
# bam 文件列表（绝对路径）
bam_list="/home/liuqibao/workspace/snp-calling/gatk-space/SLAF03/re.list"
# java 运行内存
mem=10g

(cat $bam_list ||exit 0)|while read id
do
sample=${id%%.*} ||exit 0
echo $sample

mkdir ${tmpdir}/${sample} ||exit 0
nohup \
${gatk} --java-options "-Xmx${mem} -Xms${mem} -Djava.io.tmpdir=${tmpdir}/${sample}" \
HaplotypeCaller \
-ERC GVCF \
-R ${refgenome} \
-I ${bam_dir}/${id} \
-O ${sample}_rawLikelihoods.g.vcf.gz \
1>${sample}.gvcf.log 2>&1 \
&& rm -r ${tmpdir}/${sample} \
&& rm ${bam_dir}/${sample}* \
&
done
