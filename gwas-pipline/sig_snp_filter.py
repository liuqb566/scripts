#!/bin/python
# 从多个 Cmplot 格式文件中提取显著位点，阈值分别为 1/snp个数，10/snp个数

import os

# 文件夹路径
path="/home/liuqibao/workspace/大论文/GWAS-gemma/SLAF_ms_0.4/output"
# 输出文件名
out="sig_th10.txt"
# snp个数
num=92812

os.chdir(path)
f_list=os.listdir()
f_list=[x for x in os.listdir() if 'cmplot.txt' in x]

f_out=open(out,'w')
for file in f_list:
     phe=file.split('.',1)
     with open(file,'r') as f:
         for line in f:
             l_s=line.split()
             try:
                 float(l_s[3])
             except ValueError:  #不对表头处理
                 continue
             else:
                 if float(l_s[3]) <= 1/num:
                     print("%s\t%s\t%s" %(line.strip(),"threshold=1",phe[0]),file=f_out)
                 elif 1/num < float(l_s[3]) <= 10/num:
                     print("%s\t%s\t%s" %(line.strip(),"threshold=10",phe[0]),file=f_out)
f_out.close()
