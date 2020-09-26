
#程序
bwa=bwa
#线程
t=1
#索引
FM_index="/home/liuqb/data/genome/Cotton/HAU1.0/HAU_genome.fa"


# $bwa index genome.fa
while read id
do
RG=${id#*.}
SM=${id%.*}
$bwa mem -t $t -M -R "@RG\tID:${RG}" $FM_index ${id}_1.fastq ${id}_2.fastq >${id}.sam
done < $1
