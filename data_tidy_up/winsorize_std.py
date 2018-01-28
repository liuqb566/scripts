#!/bin/python

# This script can be used to deal outlier with winsorize.
# Package: pandas
# raw data format:
#       1. must have a header
#       2. the seconde column and following columns are  data, and the first column can be index or row name whatever we do not care it.
# History:
#       gossie  2017-12-11   release 1. 

#----------------------------------------------------------------------------------------------------------------------------------------------
#your raw data
#input="/home/liuqibao/workspace/research/实验数据/SPAD数据整理/2016_2017_SPAD_汇总_终.csv"
input="/home/liuqibao/workspace/research/实验数据/光度值数据整理/浓度及变化汇总.csv"

#output file name
#output="/home/liuqibao/workspace/research/实验数据/SPAD数据整理/2016_2017_SPAD_汇总_3std.txt"
output="/home/liuqibao/workspace/research/实验数据/光度值数据整理/浓度及变化汇总_3std.txt"

# what fold of std to trim outlier
fold=3
#----------------------------------------------------------------------------------------------------------------------------------------------

import pandas as pd

# use a fold of std to trim the data,and the parameter a is the fold of std;3 fold is used in comment,but that should be set according to your requirement.
def winsorize_std(df,a):
    uplim=df.mean()+a*df.std()
    lolim=df.mean()-a*df.std()
    for i in range(1,len(df.columns)):
        df.iloc[:,i]=df.iloc[:,i].apply(lambda x: uplim[i] if x>uplim[i] else(lolim[i] if x<lolim[i] else x))
    return df

# 注意读入格式
df=pd.read_csv(input,header=0)
result=winsorize_std(df,fold)
result.fillna("NA").to_csv(output,index=None,sep='\t')
