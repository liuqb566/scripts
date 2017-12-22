#!/bin/python
# 用于筛选显著位点
#输入文件格式：CMplot 格式。前三列为snp、chr、ps，第4列之后为表型的 p value。
# python3、安装 pandas 包
#history:
#   2017-12-15 v1 gossie

# 输入文件
input="/home/liuqibao/workspace/research/chl_数据处理/355材料/GWAS_355/SLAF_ms_0.4/SPAD_result_3std_ms_0.4_maf_0.05/SPAD_pvalue_ms0.4_maf0.05.txt"
#输出文件
output="/home/liuqibao/workspace/research/chl_数据处理/355材料/GWAS_355/SLAF_ms_0.4/SPAD_result_3std_ms_0.4_maf_0.05/SPAD_threadhold_1.txt"
# 自定义阈值，0.01, 0.05, 0.1, 1 等
threadhold=1



import pandas as pd

fp=pd.read_csv(input,header=0,sep='\t')

a=threadhold/len(fp)

# 条件筛选
index=[False]*len(fp)

for x in fp.columns[3:]:
    index = index | (fp[x] < a)

fp2=fp[index]

# 替换大于阈值的数据
for x in fp2.columns[3:]:
    fp2[x][fp2[x]>a]='FLASE'

fp2.to_csv(output,index=None,sep='\t')
