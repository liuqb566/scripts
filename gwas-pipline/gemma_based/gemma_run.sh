#!/bin/bash

# gemma 路径
<<<<<<< HEAD
gemma=gemma
# 输入文件，此处为 bed 格式
bed_file="ms0.2-maf0.05"
# 相关矩阵
rel_ma="ms0.2-maf0.05.cXX.txt"
# 性状数量
num="8"

# missingness
ms=0.2
=======
gemma=~/myprogram/bio-tool/gemma
# 输入文件，此处为 bed 格式
bed_file="355_ms_0.4"
# 相关矩阵
rel_ma="355_ms_0.4.cXX.txt"
# 性状数量, 不能太多，否则gemma总会漏掉 2 个
num="2"

# missingness
ms=0.4
>>>>>>> ce752dede0d945ae2e8e2c9a19902f899e223fdb
#maf
maf=0.05

for i in `seq 1 ${num}`
do
echo $i
<<<<<<< HEAD
nohup ${gemma} -bfile  ${bed_file} -k ${rel_ma} -lmm 2 -miss ${ms} -maf ${maf} -n ${i} -o ${i} ||exit 0 &
=======
nohup ${gemma} -bfile  ${bed_file} -k ${rel_ma} -lmm 1 -miss ${ms} -maf ${maf} -n ${i} -o ${i} ||exit 0 &
>>>>>>> ce752dede0d945ae2e8e2c9a19902f899e223fdb
done

