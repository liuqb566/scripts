#! /bin/bash
# 使用前要修改，一个是要加 RG；另一个可以优化速度，并行多个进程，同时完成后对sam文件进行排序

# directory of sra files
sra_dir="~/SLAF-seq/data/raw-data/"

for i in  `ls ${sra_dir}`
do
sra=$(echo $i|cut -c 1-10)
echo $sra
#Decompresison of sra one by one
fastq-dump --split-3 -O fastq-data/ ${sra_dir}/$i || exit 0
ls -l fastq-data
bwa-0.7.15 mem -t 40 NAU_v1.1_replace_chr ./fastq-data/${sra}_1.fastq ./fastq-data/${sra}_2.fastq >${sra}.sam && ls -lh ${sra}.sam || exit 0
samtools view -Sb -o ${sra}.bam ${sra}.sam ||exit 0
rm ${sra}.sam
rm ./fastq-data/${sra}*
done
