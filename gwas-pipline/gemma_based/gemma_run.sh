#!/bin/bash

# gemma 路径
gemma=~/myprogram/bio-tool/gemma
# 输入文件，此处为 bed 格式
bed_file="355_ms_0.4"
# 相关矩阵
rel_ma="355_ms_0.4.cXX.txt"
# 性状数量, 不能太多，否则gemma总会漏掉 2 个
num="2"

# missingness
ms=0.4
#maf
maf=0.05

for i in `seq 1 ${num}`
do
echo $i
nohup ${gemma} -bfile  ${bed_file} -k ${rel_ma} -lmm 1 -miss ${ms} -maf ${maf} -n ${i} -o ${i} ||exit 0 &
done

