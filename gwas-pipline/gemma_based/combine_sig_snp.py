# sig_fileter.py
# 需要python3及pandas包
# 将本脚本拷贝到工作目录
# Gossie V1 20190305

import argparse
import re
import pandas as pd

parser=argparse.ArgumentParser(description='combine result frome sig_snp_fileter.py')
#输入文件，CMplot格式的文件
parser.add_argument('-i','--input',dest='filename',metavar='filename',nargs='*')
# 阈值
#parser.add_argument('--threadhold',metavar='threadhold',required=True,dest='threadhold',action='store',choices={'0.01','0.05','0.1','1','10'},default=1,help='a number for caculating threadhold')

args=parser.parse_args()

file_list=args.filename

df=pd.DataFrame(columns=["snp","chr","ps","pvalue","phenotype"])
for file in file_list:
# 读入文件
	f=pd.read_csv(str(file),header=0,sep='\t')
	prefix=re.match(r'\d{1,2}_(.*)\.cmplot\.sig_th*',file)
	f["phenotype"]=prefix.group(1)	
	f.columns=df.columns
	df=df.append(f,ignore_index=True)
	df.to_csv("sig_snp_all.txt",index=None,sep='\t')
