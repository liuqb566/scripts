#!/bin/bash

# gemma 路径
gemma=gemma
# 输入文件，此处为 bed 格式
bed_file="ms0.2-maf0.05"
# 相关矩阵
rel_ma="ms0.2-maf0.05.cXX.txt"
# 性状数量
num="8"

# missingness
ms=0.2
#maf
maf=0.05

for i in `seq 1 ${num}`
do
echo $i
nohup ${gemma} -bfile  ${bed_file} -k ${rel_ma} -lmm 2 -miss ${ms} -maf ${maf} -n ${i} -o ${i} ||exit 0 &
done

