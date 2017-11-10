#!/usr/bin/env python


result = open('SPAD_ay4_candidation_gene_ano.txt','w')
 
 
with open('2.txt') as fd:
    for query in fd:
        with open('NAU_annotation.txt') as fe:
            for line in fe:
                if query.split()[0] == line.split()[0]:
                    print >> result,line,
            
