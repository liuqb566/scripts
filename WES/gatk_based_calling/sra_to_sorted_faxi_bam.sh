#!/bin/bash
#用途：从 SRA 文件到比对好并排序的 bam 文件
#步骤：
#	1. sra 解压：fastq-dump。需要用 -Z 参数使双端测序交替输出到标准输出。
#	2. 比对：bwa-0.7.15。interleaved 双端测序用到 -p 参数
#	3. 排序：picard SortSam。在 java 中可以用 I=/dev/stdin O=/dev/dtdout 
#	4. 转换成 bam ：samtools-1.6 view
#	5. 建索引：samtools-1.6
#用法：
#	1. 输入文件：未解压 SRA 文件
#	2. 编辑变量
#	3. 脚本使用：脚本.sh 序列.sra
#	4. 输出文件：加好表头、排序好的 bam 文件，并建索引
#History:
# 2017-1-30 rel.2 Gossie
#==================================================================================================================================================

#参考基因组前缀，已索引
ref=~/workspace/database/genome/Gossypium_hirsutum_v1.1_replace_scaffold1000
#线程数
nt=2
# fastq-dump 路径
fd_path=fastq-dump
# bwa 路径
bwa_path=~/tools/program/bwa-0.7.15/bwa
# picard 路径
picard_path=~/tools/program/picard.jar
# samtools 路径
samtools_path=~/tools/program/samtools-1.6/samtools
#==================================================================================================================================================

# 请自定义 read group
sra_basename=`basename $1 .sra`
${fd_path} --split-3 -Z $1 \
|${bwa_path} mem -p -t ${nt} -R "@RG\tID:${sra_basename}\tLB:${sra_basename}\tPL:illumina\tSM:${sra_basename}\tPU:HAN4AADXX.2" ${ref} - \
|java -jar  ${picard_path} SortSam INPUT=/dev/stdin OUTPUT=/dev/stdout SORT_ORDER=coordinate \
|${samtools_path} view -1 - >${sra_basename}_sorted.bam && ~/tools/program/samtools-1.6/samtools index ${sra_basename}_sorted.bam

