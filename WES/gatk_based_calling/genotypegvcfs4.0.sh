#gatk4.0版

#gatk路径
gatk=/home/liuqb/tools/gatk-4.1.0.0/gatk
#参考基因组
reference=/home/liuqb/data/index/Cotton/HAU1.1/Ghirsutumv1.1_genome.fasta
#GenomicsImport产生的数据库
mydatabase=mydatabase
#输出文件名称
output=test2.vcf

$gatk GenotypeGVCFs \
-R $reference \
-V gendb://$mydatabase \
-O $output 
