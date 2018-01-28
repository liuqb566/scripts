#!/usr/bin/env python

gene="/home/liuqibao/workspace/考博文件/lqb考博报名/xinong西农/can_gene.txt"

with open(gene) as fd:
    for query in fd:
        with open('/home/liuqibao/workspace/research/database/genome/NAU_annotation.txt') as fe:
            for line in fe:
                if query.strip() == line.split()[0]:
                    print(line)
            
