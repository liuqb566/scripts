#!/bin/bash

#extract p value from gemma results
#PS:
#   Because gemma would excute some SNP when there are phenotype missing, Please be carful for the numbers of output files. So to create file with CMplot formate is better one by one 
# 第一版将所有的表型结果合并在一个文件中，这样的优点是比较精练，在画图时容易处理，但是如果某个表型中有缺失值，gemma 会忽略那个材料，导致标记减少，就无法直接用同一套标记合并。所以第二版为每个表型建立一个 CMplot 格式的文件。
# 当然，如果十分确定表型中都不含缺失值，也可以用第一个版本。
#Histry:
#   2017-12-26 v2 gossie
#----------------------------------------------------------------------------------------------------------------------------------------------
# 表型文件,与构建 .fam 文件时的表型顺序一致。
phe="/home/liuqibao/workspace/research/chl_数据处理/355材料/GWAS_355/gemma_based/re-sequencing/OD_含量_3st.txt"

#----------------------------------------------------------------------------------------------------------------------------------------------

# 表型个数
#num=`ls *.assoc.txt|wc -l|cut -d ' ' -f1`
# 不同linux版本 wc 命令显示的格式不同 
num=`ls *.assoc.txt|wc -l`

for i in `seq 1 ${num}`
do

  col=$(($i+1))
  prefix=`head -n 1 ${phe} |cut -f$col`
  #提取前三列，分别为chr,snp,ps
  cut -f2 ${i}.assoc.txt|sed 1d >snp.txt
  cut -f2 ${i}.assoc.txt|sed 1d |tr ':' '\t'|paste snp.txt - >tmp.txt
  rm snp.txt
  # 替换染色体表示方式：A01->1
  sed -i -e "s/\<A01\>/1/g" -e "s/\<A02\>/2/g" -e "s/\<A03\>/3/g" -e "s/\<A04\>/4/g" -e "s/\<A05\>/5/g" -e "s/\<A06\>/6/g" -e "s/\<A07\>/7/g" -e "s/\<A08\>/8/g" -e "s/\<A09\>/9/g" -e "s/\<A10\>/10/g" -e "s/\<A11\>/11/g" -e "s/\<A12\>/12/g" -e "s/\<A13\>/13/g" -e "s/\<D01\>/14/g" -e "s/\<D02\>/15/g" -e "s/\<D03\>/16/g" -e "s/\<D04\>/17/g" -e "s/\<D05\>/18/g" -e "s/\<D06\>/19/g" -e "s/\<D07\>/20/g" -e "s/\<D08\>/21/g" -e "s/\<D09\>/22/g" -e "s/\<D10\>/23/g" -e "s/\<D11\>/24/g" -e "s/\<D12\>/25/g" -e "s/\<D13\>/26/g" tmp.txt
  # 合并 p value，添加表头，sed 中使用变量，需要用双引号 
  cut -f11 ${i}.assoc.txt |sed 1d|paste tmp.txt -|sed "1i snp\tchr\tps\t${prefix}" - >${i}_${prefix}.cmplot.txt && rm tmp.txt
done

