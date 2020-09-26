# 计算ROD值及z-score，输入文件为vcftools产生的.pi文件。
import argparse
import re
import pandas as pd
from scipy.stats import zscore


parser=argparse.ArgumentParser(description='caculate ROD')
parser.add_argument('-i','--input',dest='input',metavar='filename',nargs='*')
parser.add_argument('-o','--output',dest='output',metavar='filename',nargs='*')
args=parser.parse_args()

f1=pd.read_csv(args.input[0],header=0,sep='\t')
f2=pd.read_csv(args.input[1],header=0,sep='\t')
f3=pd.merge(f1.iloc[:,[0,1,2,4]],f2.iloc[:,[0,1,2,4]],on=("CHROM","BIN_START","BIN_END"))
f3[['PI_x','PI_y']].astype(float)
f3['ROD']=f3['PI_x']/f3['PI_y']
zscore(f3['ROD'])
f3['zscore']=zscore(f3['ROD'])
f3.to_csv(args.output[0],header=True,index=None,sep='\t')
