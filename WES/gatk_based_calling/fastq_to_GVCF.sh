
#参考基因组(绝对路径)
Ref=/home/liuqb/data/genome/Cotton/UTX_TM1_2.1/gatk_bwa_index/Ghirsutum_527_v2.0.fa

#bwa 参数
#线程
t=10
#索引
FM_index="/home/liuqb/data/genome/Cotton/UTX_TM1_2.1/gatk_bwa_index/Ghirsutum_527_v2.0.fa"

#picard 参数
#最大运行内存
p_Xmx=20g

#GATK4参数
# 临时文件夹（绝对路径）
tmpdir="tmpdir"
# bam 文件（绝对路径）
bam_dir="."
# java 运行内存
G_Xmx=20g


while read id
do
	#解压
	gunzip -c /database/public/reseq355_clean/${id}_1.fq.gz >${id}_1.fq
	gunzip -c /database/public/reseq355_clean/${id}_2.fq.gz >${id}_2.fq
	#提取read group信息
	grep "^@ST" ${id}_1.fq|cut -d ':' -f1-4|sort|uniq >${id}.RG.table

	while read rg
	do
		affix=`echo $rg|tr ":" "-"`
		#根据read group分隔文件
		grep -A 3 ${rg} ${id}_1.fq >${id}-${affix}_1.fq
		grep -A 3 ${rg} ${id}_2.fq >${id}-${affix}_2.fq
	done <${id}.RG.table

	rm ${id}_1.fq ${id}_2.fq

	# bwa 比对
	while read rg
	do
		affix=`echo $rg|tr ":" "-"`
		bwa mem -t $t -M -R "@RG\tID:${affix}\tSM:${id}\tLB:${id}\tPL:illumina" $FM_index ${id}-${affix}_1.fq ${id}-${affix}_2.fq >${id}-${affix}.sam && rm ${id}-${affix}_*.fq
	done <${id}.RG.table

	
	
	#用picard合并sam，排序，输出bam,index
	#java -Djava.io.tmpdir=${tmpdir} -jar picard.jar
	ls ${id}-*.sam|xargs -I [] echo "I="[]|xargs -L 1000000 \
	picard -Xmx${p_Xmx} MergeSamFiles \
	O=${id}.merged.sorted.bam \
	SORT_ORDER=coordinate \
	CREATE_INDEX=true \
	VALIDATION_STRINGENCY=LENIENT \
	REFERENCE_SEQUENCE=$Ref	\
	TMP_DIR=${tmpdir} 2>${id%}.log \
	&&rm ${id}-*.sam
	
       # Mark duplicates
	# MarkDuplicates 排序会出问题；且MarkDuplicates应该不会改变顺序，仅建索引就可以
	picard -Xmx${p_Xmx} MarkDuplicates \
	I=${id}.merged.sorted.bam \
	O=${id}.merged.sorted.dedup.bam \
	M=${id}.Marked_dup_metrics.txt \
	CREATE_INDEX=true \
	VALIDATION_STRINGENCY=LENIENT \
	REFERENCE_SEQUENCE=$Ref	\
	TMP_DIR=${tmpdir} 2>${id%}.log \
	&& rm ${id}.merged.sorted.bam*
	
	# samtools建立索引，picard MarkDuplicates建索引有时出问题
	#samtools index ${id}.merged.sorted.dedup.bam || exit 0
	
	#`-DF NotDuplicateReadFilter`：使用该参数则禁止对reads duplicate进行过滤，GBS或RNA-seq数据可能需要。
	if [ ! -f "${tmpdir}/${id}_h" ];then

		mkdir -p ${tmpdir}/${id}_h
	else
		rm -r ${tmpdir}/${id}_h/*
	fi
	gatk --java-options "-Xmx${G_Xmx} -Djava.io.tmpdir=${tmpdir}/${id}_h" \
	HaplotypeCaller \
	-ERC GVCF \
	-R ${Ref} \
	-I ${id}.merged.sorted.dedup.bam \
	-O ${id}.gvcf.gz \
	1>${id}.gvcf.log 2>&1 \
	&& rm -r ${tmpdir}/${id}_h 
	

done < $1
