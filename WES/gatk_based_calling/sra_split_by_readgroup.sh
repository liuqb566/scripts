# 如果SRR数据来自不同的lane,根据lane确定read group，用于GATK BQSR
while read id
do
	#用Instrument ID:run number:flowcell ID:lane作为RG
	grep "^@SRR" ${id}.sra_1.fastq |cut -d ':' -f1-4|cut -d ',' -f2|sort|uniq >RG.table
	cat RG.table|while read rg
	do
		grep -A 1 ${rg} ${id}.sra_1.fastq >${id}.${rg}_1.fastq
		grep -A 1 ${rg} ${id}.sra_2.fastq >${id}.${rg}_2.fastq
	done
done < $1

