#!/usr/bin/python
import re

with open('snp.txt','r') as fd1:
    for line in fd1:
        chromosome = line.split()[0]
        pos = line.split()[1]
        with open('NAU.gff3','r') as fd2:
            for ll in fd2:
                ll_list = ll.split()
                if chromosome == ll_list[0] and int(ll_list[3]) > (int(pos)-450000) and int(ll_list[4]) < (int(pos)+450000) and ll_list[2]=='gene':
                    m = re.search(r'(Gh\w+\d+);',ll_list[8])
                    result = '%s\t%s\t%s' % (m.group(1),ll_list[3],ll_list[4])
                    print result



