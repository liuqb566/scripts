#! /bin/python
#The script need pandas, python3
#History:
#       20171015 gossie rev.1

import pandas as pd

fdom=pd.read_csv('dom_region.txt',header=0,sep='\t') #a domestication file including chr, start and end
fimp=pd.read_csv('imp_region.txt',header=0,sep='\t') #a improving region file including...
f_out=open('result.txt','a')

for i in range(len(fdom)):
    for j in range(len(fimp)):
        a=fdom.iloc[i,1]
        b=fdom.iloc[i,2]
        c=fimp.iloc[j,1]
        d=fimp.iloc[j,2]
        if fdom.iloc[i,0]==fimp.iloc[j,0]:
            if a <= c < b <= d:
                print("""
                Domestication region is:
                %s
                Improving region is:
                %s
                Overlapping region is:
                start: %s, end: %s, size: %s"""%(fdom.iloc[i],fimp.iloc[j],c,b,b-c+1),file=f_out)
            elif a < c < d < b:
                print("""
                Domestication region is:
                %s
                Improving region is:
                %s
                Overlapping region is:
                start: %s, end: %s, size: %s"""%(fdom.iloc[i],fimp.iloc[j],c,d,d-c+1),file=f_out)
            elif c < a < b < d:
                print("""
                Domestication region is:
                %s
                Improving region is:
                %s
                Overlapping region is:
                start: %s, end: %s, size: %s"""%(fdom.iloc[i],fimp.iloc[j],a,b,b-a+1),file=f_out)
            elif c <= a < d <= b:
                print("""
                Domestication region is:
                %s
                Improving region is:
                %s
                Overlapping region is:
                start: %s, end: %s, size: %s"""%(fdom.iloc[i],fimp.iloc[j],a,d,d-a+1),file=f_out)

