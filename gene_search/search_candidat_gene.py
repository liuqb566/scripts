#!/usr/bin/python

#上游
up=15000
#下游
down=15000
#注释文件
GFF='/home/liuqibao/workspace/research/database/genome/NAU_replace.gff3'
# snp 文件
SNP='/home/liuqibao/workspace/考博文件/lqb考博报名/xinong西农/ppt/snp.txt'
import re

with open(SNP,'r') as fd1:
    for line in fd1:
        chromosome = line.strip().split(":")[0]
        pos = line.strip().split(":")[1]
        with open(GFF,'r') as fd2:
            for ll in fd2:
                ll_list = ll.split()
                if chromosome == ll_list[0] and int(ll_list[3]) > (int(pos)-up) and int(ll_list[4]) < (int(pos)+down) and ll_list[2]=='gene':
                    m = re.search(r'(Gh\w+\d+);',ll_list[8])
                    result = '%s\t%s\t%s' % (m.group(1),ll_list[3],ll_list[4])
                    print (result)



