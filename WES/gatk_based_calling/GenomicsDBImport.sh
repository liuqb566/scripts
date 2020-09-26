
gatk=/home/liuqb/tools/gatk-4.1.0.0/gatk
# 必需的文件，具体格式参考GATK
interval_list=chrom.list
# Java内存限制
Xmx=100g
Xms=10g
# 输出文件夹，必须是未创建的或者空的文件夹
my_database=mydatabase2
# 分几个批次读入样本，默认 0, 表示一次性读入
batch_size=0
# gvcf文件列表，每行格式为“gvcf文件名	路径”，具体格式参考GATK
map_file=sample.map
# 每个batch的并行线程
reader_threads=10

$gatk --java-options "-Xmx$Xmx -Xms$Xms" \
GenomicsDBImport \
--genomicsdb-workspace-path $my_database \
--intervals $interval_list \
--merge-input-intervals True \
--batch-size  $batch_size \
--sample-name-map $map_file \
--reader-threads $reader_threads 
