#!/bin/bash

#extract p value from gemma results
#PS:
#   Because gemma would excute some SNP when there are phenotype missing, Please be carful for the numbers of output files.
#history:
#    2017-12-13 v1 gossie



# output
output="浓度_p_value.txt"
# 表型文件,与构建 .fam 文件时的表型顺序一致。
phe="/home/liuqibao/workspace/research/chl_数据处理/SPAD数据处理/355材料/GWAS_355/浓度及变化汇总_3std.txt"
# 表型个数
num=48



#提取前三列，分别为chr,snp,ps
cut -f2 1.assoc.txt|sed 1d >snp.txt
cut -f2 1.assoc.txt|sed 1d |tr ':' '\t'|paste snp.txt - |sed '1i snp  chr ps' >${output}
rm snp.txt

# 替换染色体表示方式：A01->1
sed -i "s/\<A01\>/1/g" ${output};sed -i "s/\<A02\>/2/g" ${output};sed -i "s/\<A03\>/3/g" ${output};sed -i "s/\<A04\>/4/g" ${output};sed -i "s/\<A05\>/5/g" ${output};sed -i "s/\<A06\>/6/g" ${output};sed -i "s/\<A07\>/7/g" ${output};sed -i "s/\<A08\>/8/g" ${output};sed -i "s/\<A09\>/9/g" ${output};sed -i "s/\<A10\>/10/g" ${output};sed -i "s/\<A11\>/11/g" ${output};sed -i "s/\<A12\>/12/g" ${output};sed -i "s/\<A13\>/13/g" ${output};sed -i "s/\<D01\>/14/g" ${output};sed -i "s/\<D02\>/15/g" ${output};sed -i "s/\<D03\>/16/g" ${output};sed -i "s/\<D04\>/17/g" ${output};sed -i "s/\<D05\>/18/g" ${output};sed -i "s/\<D06\>/19/g" ${output};sed -i "s/\<D07\>/20/g" ${output};sed -i "s/\<D08\>/21/g" ${output};sed -i "s/\<D09\>/22/g" ${output};sed -i "s/\<D10\>/23/g" ${output};sed -i "s/\<D11\>/24/g" ${output};sed -i "s/\<D12\>/25/g" ${output};sed -i "s/\<D13\>/26/g" ${output}

for i in `seq 1 ${num}`
do
cut -f11 ${i}.assoc.txt |paste ${output} - >tmp.txt
mv tmp.txt ${output}
done

# 将P value 的表头替换为相应表型名称
head -n 1 ${phe} |cut -f2-|xargs -i echo -e 'snp\tchr\tps\t'{} >header.txt ||exit 0
tail -n +2 ${output} >>header.txt && mv header.txt ${output}


