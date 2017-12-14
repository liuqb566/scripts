#!/bin/python3

######################################################################
#Function:summary data from mutiple fastqc result                    #
#How use it:run in the folder including fastqc result(_fastqc.zip)   #
#History:                                                            #
#   2017-11-8   release 1   gossie                                   #
######################################################################

import re
import os
import zipfile



#definition of functions

#parses out the fastqc_data.txt. 'zifle' is a zip file from the resultof fastQC program and fastqc_data_path is the pathway of 'fastqc_data.txt'.
def parse_fastqc_data(zfile,fastqc_data_path):
    #Returns a dictory and the keys is 'title', and the value of 'title' also is a dictory with keys 'header' and 'value' that their value is list of list.
    fastQC={}
    title=None
    header=None
    z_file=zfile.open(fastqc_data_path,'r')
    for line in z_file:
        line=line.decode("utf8").strip()
        if line.startswith(">>END_MODULE"):
            title=None
            header=None
        elif line.startswith('>>'):
            title=line[2:].split('\t')[0].lower().replace(' ','_')
            fastQC[title]={'header':[],'value':[]}
        elif title is not None:
            if line.startswith('#'):
                header=line[1:].split('\t')
                fastQC[title]['header'].append(header)
            elif header is not None:
                value=line.split('\t')
                fastQC[title]['value'].append(value)
    z.close()
    return fastQC

#extract data from 'basic_statistics'
def extract_basic_statistics(fastQC):

    value_dic=fastQC['basic_statistics']['value']
    #get 'Filename', 'Total Sequences', 'Sequence length' and '%GC'
    header='\t'.join([value_dic[0][0],value_dic[3][0],value_dic[5][0],value_dic[6][0]])
    value='\t'.join([value_dic[0][1],value_dic[3][1],value_dic[5][1],value_dic[6][1]])

    return [header,value]

#extract data from 'per_base_sequence_quality'
def extract_per_base_sequence_quality(fastQC):
    value_dic=fastQC['per_base_sequence_quality']['value']
    Q20=0
    Q30=0
    for x in value_dic:
        if float(x[1])>=20:
            Q20+=1
            Q30+=1
        elif float(x[1])>=30:
            Q30+=1

    value=str(Q20/len(value_dic))+'\t'+str(Q30/len(value_dic))
    return ['Q20\tQ30',value]


#get all _fastqc.zip in current path, tidy up data
zfile_list=[zfile for zfile in os.listdir() if '_fastqc.zip' in zfile]

header=None
row=[]
for zfile in zfile_list:
    z=zipfile.ZipFile(zfile,'r')
    path=[file for file in z.namelist() if '_data.txt' in file][0]
    fastQC=parse_fastqc_data(z,path)
    result1=extract_basic_statistics(fastQC)
    result2=extract_per_base_sequence_quality(fastQC)

    if header is None:
        header='\t'.join([result1[0],result2[0]])
    row.append(result1[1]+'\t'+result2[1])

with open('fastqc_summary.txt','wt') as f:
    print(header,'\n'.join(row),sep='\n',file=f)

#summary one section is 'pass', 'warning' or 'fail'
with open('fastqc_pass_result.txt','wt') as f:
    header='File name'
    row=[]
    for zfile in zfile_list:
        z=zipfile.ZipFile(zfile,'r')
        path=[file for file in z.namelist() if 'summary' in file][0]

        value=None
        for line in z.open(path,'r'):
            line=line.decode('utf8')
            line_split=line.strip().split('\t')
            if value is None:
                value=line_split[2]
            else:
                value=value+'\t'+line_split[0]

            if 'Kmer' not in header:
                header=header+'\t'+line_split[1]
        row.append(value)
    print(header,'\n'.join(row),sep='\n',file=f)
