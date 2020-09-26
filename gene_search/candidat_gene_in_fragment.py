#!/usr/bin/python
import re

# fragment file，txt 文件，三列：染色体、起始位置、终止位置；有表头
ff="At_Dt_sweeps.txt"
# 注释文件
gff="/home/liuqibao/workspace/research/database/genome/NAU.gff3"
# 基因上游
up=2000
# 基因下游
down=2000

with open(ff,'r') as f1:
    for line in f1:
        chromosome = line.split()[0]
        start = line.split()[1]
        end = line.split()[2]
        with open(gff,'r') as f2:
            for ll in f2:
                ll_list = ll.split()
                m=re.search(r'(Gh\w+\d+);',ll_list[8])
                if chromosome == ll_list[0] and ll_list[2]=='gene': 
                    if int(ll_list[3])-up >= int(start) and int(ll_list[4])+down <= int(end):
                        print("%s\t%s\t%s\t%s\t%s\t%s\t内" %(chromosome,start,end,m.group(1),ll_list[3],ll_list[4]))
                    elif int(ll_list[3])-up < int(start) < int(ll_list[4])+down:
                        print("%s\t%s\t%s\t%s\t%s\t%s\t头" %(chromosome,start,end,m.group(1),ll_list[3],ll_list[4]))
                    elif int(ll_list[3])-up < int(end) < int(ll_list[4])+down:
                        print("%s\t%s\t%s\t%s\t%s\t%s\t尾" %(chromosome,start,end,m.group(1),ll_list[3],ll_list[4]))
