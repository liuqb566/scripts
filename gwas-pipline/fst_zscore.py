# 计算z-score，输入文件为vcftools产生的fst文件。
import argparse
import re
import pandas as pd
from scipy.stats import zscore


parser=argparse.ArgumentParser(description='caculate zscore')
parser.add_argument('-i','--input',dest='input',metavar='filename',nargs='*')
args=parser.parse_args()
f_list=args.input
for f in f_list:
    fst=pd.read_csv(str(f),header=0,sep='\t')
    fst['zscore']=zscore(fst[['MEAN_FST']].astype(float))
    fst.to_csv(str(f)+".zscore",header=True,index=None,sep='\t')
