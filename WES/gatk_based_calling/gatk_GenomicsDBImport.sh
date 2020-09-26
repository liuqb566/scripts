
gatk=gatk
# 必需的文件，具体格式参考GATK
interval_list=chr.list
# Java内存限制
Xmx=100g
Xms=10g
# genomicsdb，必须是未创建的或者空的文件夹
my_database=UTX_Genomicsdb
# 每批次读入多少样本，默认 0, 表示一次性全部读入注意，一次读入过多样本会发生错误，建议每次读入不多于100个;
batch_size=1
# gvcf文件列表，每行格式为“gvcf文件名	路径”，具体格式参考GATK
map_file=all.map
# 每个batch的并行线程
reader_threads=1
#同时读入的最大intervals数量,值越高，速度越快，但消耗更多的内存，且需要有权限创建足够多的文件.
num=26
#缓存文件
tmp=tmpdir2


#--merge-input-intervals True \
#第一次建库用的命令：
# --genomicsdb-workspace-path $my_database \
#第二次建库用的命令
#--genomicsdb-update-workspace-path $my_database \

$gatk --java-options "-Xmx$Xmx -Xms$Xms" \
GenomicsDBImport \
--genomicsdb-workspace-path $my_database \
--intervals $interval_list \
--batch-size  $batch_size \
--sample-name-map $map_file \
--reader-threads $reader_threads \
--max-num-intervals-to-import-in-parallel $num \
--tmp-dir ${tmp}
