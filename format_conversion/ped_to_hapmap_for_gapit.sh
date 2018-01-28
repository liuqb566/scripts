#!/bin/bash
#
#----------------------------------------------------------------------------------------------------------------------------------------------
# gapit 软件基因型的输入文件可以是 hapmap 格式。hapmap 格式可以通过 vcf 格式转换（用 vcftools，最方便），如果只有 PED 格式，就需要自己写脚本转换，但是会丢失很多信息。
# hapmap 格式前 11 列是标记信息，12 列是个体的基因型：
# rs	allels	chrom	pos	strand	assembly	center	protLSID	assayLSID	panel	QCcode
# gapit 软件只需要读取前 11 列的 rs 、chrom、pos 三列，其它列可以用 NA 填充
# 
# plink 有一种 TPED/TFAM 格式，是 PED 格式的转置，正好与 hapmap 相似，仅需要再填充其他列。
#注意：PED 格式必须是 tab 分隔的！！否则在加表头的时候，cut会不识别而出错。当然，也可以自己去指定分隔符
#--------------------------------------------------------------------------------------------------------------------------------------------- 
#History:
#   2017-12-23 v1 Gossie
#--------------------------------------------------------------------------------------------------------------------------------------------- 

#--------------------------------------------------------------------------------------------------------------------------------------------- 
# 以下变量请自己更改
# 保存 PED 文件的目录
workspace=/home/liuqibao/workspace/research/database/SLAF_snp/geno0.4_maf0.05/
# PED 格式文件的前缀，.ped 和 .map 文件前缀必须一致
pre_ped=geno0.4_maf0.05
# 输出文件名
output=geno0.4_maf0.05.hmap.txt
# plink 软件
plink=~/myprogram/bio-tool/plink-1.07-x86_64/plink
#--------------------------------------------------------------------------------------------------------------------------------------------- 

# 保存当前目录，转到工作目录
current=`pwd`
cd $workspace
# 先将 PED 格式转换成 .tped 格式, --tab 使个体基因型间用 \t 分隔，基因型内用 空格 分隔
${plink} --noweb --file ${pre_ped} --tab --transpose --recode --out ${pre_ped}

# snp 标记名称，hapmap 的第一列，必须
cut -f2 ${pre_ped}.tped >snp.txt
# 标记位置，hapmap的第 4 列，必须
cut -f4 ${pre_ped}.tped >ps.txt
# 个体基因型，12 列往后, 同时将基因型内分隔符去掉（hapmap 格式需要）
cut -f5- ${pre_ped}.tped|sed 's/ //g' >geno.txt
# chromesome，数字表示，hapmap第3列，必须
cut -d ':' -f1 snp.txt>chr.txt
# 将 chromesome 转换成数字表示
sed -i "s/\<A01\>/1/g" chr.txt;sed -i "s/\<A02\>/2/g" chr.txt;sed -i "s/\<A03\>/3/g" chr.txt;sed -i "s/\<A04\>/4/g" chr.txt;sed -i "s/\<A05\>/5/g" chr.txt;sed -i "s/\<A06\>/6/g" chr.txt;sed -i "s/\<A07\>/7/g" chr.txt;sed -i "s/\<A08\>/8/g" chr.txt;sed -i "s/\<A09\>/9/g" chr.txt;sed -i "s/\<A10\>/10/g" chr.txt;sed -i "s/\<A11\>/11/g" chr.txt;sed -i "s/\<A12\>/12/g" chr.txt;sed -i "s/\<A13\>/13/g" chr.txt;sed -i "s/\<D01\>/14/g" chr.txt;sed -i "s/\<D02\>/15/g" chr.txt;sed -i "s/\<D03\>/16/g" chr.txt;sed -i "s/\<D04\>/17/g" chr.txt;sed -i "s/\<D05\>/18/g" chr.txt;sed -i "s/\<D06\>/19/g" chr.txt;sed -i "s/\<D07\>/20/g" chr.txt;sed -i "s/\<D08\>/21/g" chr.txt;sed -i "s/\<D09\>/22/g" chr.txt;sed -i "s/\<D10\>/23/g" chr.txt;sed -i "s/\<D11\>/24/g" chr.txt;sed -i "s/\<D12\>/25/g" chr.txt;sed -i "s/\<D13\>/26/g" chr.txt

# allels strand assembly center protLSID assayLSID panel QCcode 列用 NA 填充
num=`wc -l ${pre_ped}.tped|cut -d ' ' -f1`
for i in `seq 1 ${num}`;do echo NA >>model.txt;done
echo -e 'allels\nstrand\nassembly\ncenter\nprotLSID\nassayLSID\npanel\nQCcode'|while read id;do cp model.txt ${id}.txt;done

# 按顺序合并所有文件
paste snp.txt allels.txt chr.txt ps.txt strand.txt assembly.txt center.txt protLSID.txt assayLSID.txt panel.txt QCcode.txt geno.txt >${output}

# add header, ped 文件必须用’\t'分隔,tr 转换过程中最后会多出一个 \t，导致读入R的时候出现错误, 必须删除。
cut -f1 ${pre_ped}.ped|tr '\n' '\t'|sed "s/\t$//g"|xargs -i sed -i "1i rs\tallels\tchrom\tpos\tstrand\tassembly\tcenter\tprotLSID\tassayLSID\tpanel\tQCcode\t{}" ${output}

# 删除临时文件
rm model.txt snp.txt allels.txt chr.txt ps.txt strand.txt assembly.txt center.txt protLSID.txt assayLSID.txt panel.txt QCcode.txt geno.txt *.tped *.tfam
# 返回初始目录
cd $current
