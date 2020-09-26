#gatk4.0版

#gatk路径
gatk=gatk
#参考基因组
reference=/home/liuqb/data/genome/Cotton/UTX_TM1_2.1/gatk_bwa_index/Ghirsutum_527_v2.0.fa
#GenomicsImport产生的数据库
mydatabase=UTX_Genomicsdb
#输出文件名称
#output=355.raw.UTX.vcf
#intervals文件
intervals=chr.list
#运行内存
Xmx=20g
Xms=1g
#缓存文件夹
tmp=tmpdir

cat $intervals|while read id
do
	if [ ! -f "${tmp}/chr_${id}" ];then

		mkdir -p ${tmp}/chr_${id}
	else
		rm -r ${tmpdir}/chr_${id}/*
	fi
nohup $gatk --java-options "-Xmx$Xmx -Xms$Xms" GenotypeGVCFs \
-R $reference \
-V gendb://$mydatabase \
-L $id \
-O ${id}.vcf.gz \
--tmp-dir ${tmp}/chr_${id} \
>chr_${id}.log 2>&1 &

done <$1
