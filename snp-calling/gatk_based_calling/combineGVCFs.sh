#!/bin/bash

# GenotypeGVCF 程序运行的 gvcf 文件最好不要超过 200 个（300 也可以，太多就会消耗非常大的内存）。所以如果样本太多，产生了大量的 g.vcf 文件，需要用 CombineGVCFs 程序将适量的 gvcf 文件合并成一个 .g.vcf 文件。
# 需要注意的是 CombineGVCFs 程序也比较耗时。请合理取舍。
# CombineGVCFs 好像不能使用多线程，可行的减少时间的方法是 -L 参数，分别对染色体进行合并。

#注意都用绝对路径
#gatk：GenomeAnalysisTK.jar
#tmpdir：临时文件目录。最好指定一个；如果默认目录太小，在并行运算的时候会报错, 可能会导致程序终止。
#regeneme：参考基因组文件。同文件夹下要有 .dic 和 .fai 文件
#############################################
#2017-12-14	V2	Gossie      #########
#	V2: 可以自主设定合并几个 gvcf 文件####
############################################

# gatk 程序绝对路径
gatk="/home/liuqibao/tools/program/GenomeAnalysisTK-3.8-0-ge9d806836/GenomeAnalysisTK.jar"
# 临时文件夹（绝对路径）
tmpdir="/home/liuqibao/workspace/snp-calling/gatk-space/tmp"
# 参考基因组（绝对路径）
refgenome="/home/liuqibao/workspace/database/Gossypium_hirsutum_v1.1_replace.fa"
# gvcf 文件列表，必须用 .list 后缀
gvcf="gvcf_all.list"
# 需要合并 gvcf 文件个数
num=4

# 总 gvcf 文件
total_line=`wc -l ${gvcf}|cut -d ' ' -f1`
# 合并 gvcf 文件计数器
count=0
# 已合并 gvcf 文件计数器
total=0
# 合并文件名字
name=1

cat ${gvcf}|while read id 
do 
	let count+=1
	let total+=1
	condition=$[${count} % ${num}]
	if test "${condition}" != "0" && test ${total} != ${total_line}
	then 
		echo ${id} >>tmp_${name}.list 
	elif test "${condition}" = "0" || test ${total} = ${total_line} 
	then 
		echo ${id} >>tmp_${name}.list 
		# combineGVCFs 运行, 结束后删除 tmp.list, 计数器归 0
		mkdir ${tmpdir}/${name}_combine

		nohup \
		java -Djava.io.tmpdir=${tmpdir}/${name}_combine -jar ${gatk} \
		-T CombineGVCFs \
		-R ${refgenome} \
		--variant tmp_${name}.list \
		-o combine_${num}_${name}.g.vcf \
		1>combine_${num}_${name}.log 2>&1 && \
		cat tmp_${name}.list >>combine_${num}_${name}.log &&\
		rm tmp_${name}.list &&\
		rm -r ${tmpdir}/${name}_combine &

		count=0 
		let name+=1
	fi
done

