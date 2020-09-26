# sig_fileter.py
# 从CMplot格式文件中提取显著SNP
# 需要python3及pandas包
# 将本脚本拷贝到工作目录
# Gossie V1 20190305

import argparse
import re
import pandas as pd

parser=argparse.ArgumentParser(description='filter significant snp from CMplot formted file')
#输入文件，CMplot格式的文件
parser.add_argument('-i','--input',dest='filename',metavar='filename',nargs='*')
# 阈值
parser.add_argument('-t','--threadhold',metavar='threadhold',required=True,dest='threadhold',action='store',choices={'0.01','0.05','0.1','1','10'},default=1,help='a number for caculating threadhold')

args=parser.parse_args()

file_list=args.filename

for file in file_list:
# 读入文件
	f=pd.read_csv(str(file),header=0,sep='\t')
#计算阈值
	th=int(args.threadhold)/len(f)
	result=f[f.iloc[:,3]<th]
	prefix=re.match(r'(.*)\.(txt)',file)
	output=prefix.group(1)+'.sig'+'_th'+args.threadhold+'.txt'
	result.to_csv(output,index=None,sep='\t')
