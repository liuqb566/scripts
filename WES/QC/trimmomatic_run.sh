#! /bin/bash
#history:
#	Gossie V1 20190101

#用trimmomatic对进行测序数据质量控制
#需要一个包含样本名称的单列文件

#线程
t=8
# 模式PE（双端）或者SE（单端）
mode='PE'

#以下参数适情况修改、添加。
#ILLUMINACLIP模式
#接头文件，fasta格式。注意：不同的命名格式有差别。
fastaWithAdapterEtc='adapter.fa'
#第一步搜索时允许搞错错配碱基个数，通常为1-2.
seed_mismatches=2
#双端测序的palindrome模式下，连上接头的两条reads的比对阈值
palindrome_clip_threshold=30
#切除的接头序列的最低比对分值，通常为7-15.
simple_clip_threshold=10
#仅对palindrome模式有效，双端测序palindrome模式下，可以切除的接头的最短长度。默认是8。但，可以设置为1.
minAdapterlength=1
#仅对palindrome模式有效。默认为false。
keepBothReads=true

# SLIDINGWINDOW:滑窗模式。从5‘端开始滑动，切除平均质量小于阈值的片段。
#窗口大小
windowSize=0
#质量
requiredQuality=0

#LEADING:切除起位置小于阈值的碱基
lead_quality=0
#TRAILING:切除末尾位置小于阈值的碱基
trail_quality=0
#CROP:从末尾切除read部分碱基，使reads达到指定长度.
crop_length=150
#HEADCROP:切除起始位置特定长度的碱基
headcrop=15
#MINLEN:舍弃小于给定长度的
minlen=100
#AVGQUAL：舍弃平均质量低于给定水平的read
avgqual=20

while read id
do
nohup trimmomatic PE -threads $t ${id}1.fq.gz ${id}2.fq.gz -baseout ${id}.fg.gz HEADCROP:$headcrop ILLUMINACLIP:$fastaWithAdapterEtc:$seed_mismatches:$palindrome_clip_threshold:$simple_clip_threshold:$minAdapterlength:$keepBothReads MINLEN:$minlen & 
done < $1
