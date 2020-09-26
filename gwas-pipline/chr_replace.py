#!/bin/env python

#写这个脚本是为了将南农基因的组的染色体编号（eg，‘A01’）替换成纯数字格式，以便用‘CMplot'画Manhattan图。这个脚本的输出文件（result.txt）有两列，第1列是数字格式的染色体ID，第二列是snp ID，没有表头。
#注意：需要一个输入文件做参数，输入文件仅一列，即 A01:21345 格式，请使用python3运行。

#history:
#    2017-8-1 gossie release.1

import sys
f_input=sys.argv[1]
def chr_replace(f_input):
#创建一个字典
    a=['A']*13+['D']*13 
    b=['01','02','03','04','05','06','07','08','09','10','11','12','13']*2
    c=[x+y for x,y in zip(a,b)]
    D=dict(zip(c,list(range(1,27))))
#打开一个输出文件
    f_out=open('result.txt','a')

    with open(f_input,'rt') as f:
        for line in f:
            snp=line.strip()
            chromesome=snp.split(':')[0]
            print(snp,D[chromesome],sep='\t',file=f_out)

    f_out.close()

if __name__=="__main__":
    chr_replace(f_input)
    

