
#
#该脚本用于haploview.sh的结果的后续处理，主要目标是过滤出与snp所在的LD blocks。
#

import os
import argparse
import re
import subprocess
import pandas as pd

# 输入参数，一个含有所有snp的列表文件,需要与haploview.sh中的snp文件相同
parser=argparse.ArgumentParser(description='')
parser.add_argument('-i','--input',required=True,dest='filename',metavar='filename')
args=parser.parse_args()
snp_file=args.filename

#包含所有snp的列表文件
snp_all=pd.read_csv(snp_file,header=None,sep='\t')
#统计有多少个snp
lenth=len(snp_all)
#输出文件
output=open("ldblock_summary.txt","w")
print("snp","chr","start","end","LDblocks",file=output,sep='\t',end='\n')

#pd.DataFrame默认行宽50,修改成1000,以免出现显示不全的问题。
pd.set_option('max_colwidth',1000)

for i in range(1,lenth+1):
	index=i-1
	snp=str(snp_all.iloc[index,0])
	commands="ls "+snp+".chr-*.info"
	#读入haploview的info文件
	info=pd.read_csv(subprocess.getoutput(commands),header=None,sep='\t')	
	#提取snp序列号
	num=int(info[info[0]==snp].index.tolist()[0])+1
	#读入来自haploview的LD Blocks文件
	blockfile=pd.read_csv(snp+".GABRIELblocks",header=None)
	#提取含有目的snp的LD block
	block=blockfile[blockfile[0].str.contains("MARKERS") & blockfile[0].str.contains(str(num))]
	#如果不是空集，将snp序列号替换为snp ID
	if block.empty is False:
		snp_list=str(block).split(':')[1].strip().split()	
		snp_list2=[]
		for x in snp_list:
			snp_list2.append(info.iloc[int(x)-1,0])
		#染色体
		chr=str(snp_list2[0]).split("_")[0]
		#起始位置
		start=str(snp_list2[0]).split("_")[1]
		#终止位置
		end=str(snp_list2[-1]).split("_")[1]
		print(snp,chr,start,end,"/".join(snp_list2),file=output,sep='\t',end='\n')
	else:
		#染色体
		chr=snp.split("_")[0]
		#起始位置
		start=snp.split("_")[1]
		#终止位置
		end=snp.split("_")[1]
		print(snp,chr,start,end,snp,file=output,sep='\t',end='\n')

output.close()
