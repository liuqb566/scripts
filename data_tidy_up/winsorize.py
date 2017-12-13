#!/bin/python

# This script can be used to deal outlier with winsorize.
#You can use percentile or std in winsorize.
# History:
#       gossie  2017-7-28   release 1. 

import pandas as pd
from copy import deepcopy

# limits is the up and/or low percetage that you want to trim.eg. if you want to trim 0.1 of the data totally,the limists is 0.05.
def winsorize_percentage(myfile,limits):
    df=deepcopy(myfile)
    uplim=df.quantile(1-limits)
    lolim=df.quantile(limits)
    for i in range(1,len(df.columns)):
        df.iloc[:,i]=df.iloc[:,i].apply(lambda x: uplim[i] if x>uplim[i] else(lolim[i] if x<lolim[i] else x))
    return df

# use a fold of std to trim the data,and the parameter a is the fold of std;3 fold is used in comment,but that should be set according to your requirement.
def winsorize_std(myfile,a):
    df=deepcopy(myfile)
    uplim=df.mean()+a*df.std()
    lolim=df.mean()-a*df.std()
    for i in range(1,len(df.columns)):
        df.iloc[:,i]=df.iloc[:,i].apply(lambda x: uplim[i] if x>uplim[i] else(lolim[i] if x<lolim[i] else x))
    return df
