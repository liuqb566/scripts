#!/usr/bin/python
#the script for extract gene, up stream, down stream from genome;The input file include gene ID line by line
#python version: python2
#genenome: NAU-v1.1
#History:
#   2017-11-2 v1 gossie

import re
ha = {}

#construct dictory for genome
with open('/home/liuqibao/workspace/research/database/genome/Gossypium_hirsutum_v1.1.fa','r') as fd:
    for line in fd:
        line = line.strip()
        if line.startswith('>'):
            k = line[1:]
            seq = ''
        else:
            seq += line
        ha[k] = seq


with open('gene.txt','r') as gf:
    for geneid in gf:
        geneid=geneid.strip()
        with open('/home/liuqibao/workspace/research/database/genome/NAU.gff3','r') as gff:
            for ll in gff:
                ll_list = ll.strip().split()
                if geneid in ll and ll_list[2]=='gene':
                    chr=ll_list[0]
                    up_start=int(int(ll_list[3])-1000)
                    gene_start=int(ll_list[3])
                    gene_end=int(ll_list[4])
                    down_end=int(int(ll_list[4])+1000)
                    for k in ha.keys():
                        if k == chr:
                            gene_sequence=ha[k][gene_start-1:gene_end]
                            up_stream=ha[k][up_start-1:gene_start-1]
                            down_stream=ha[k][gene_end:down_end]
                            print '>%s\n%s\n>%s\n%s\n>%s\n%s' %(geneid,gene_sequence,geneid+"_up",up_stream,geneid+"_down",down_stream)



