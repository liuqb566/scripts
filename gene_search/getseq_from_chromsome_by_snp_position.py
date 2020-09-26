#!/usr/bin/python

ha = {}


with open('/Users/lilibei/Desktop/D.fa') as fd:
    for line in fd:
        line = line.strip()
        if line.startswith('>'):
            k = line[1:]
            seq = ''
        else:
            seq += line
        ha[k] = seq
            


          
with open('/Users/lilibei/Desktop/1.txt') as fd:
    for line in fd:
        line = line.split()
        chromosome = line[0]
        start = int(line[1])
        end = int(line[2])
        ID = line[3]
        for k in ha.keys():
            if k ==  chromosome:
                sequence = ha[k][start-1:end]
                print '>%s\n%s' % (ID,sequence) 
     