#计算gwas loci 周围一定r2的范围
#输入文件为plink计算r2产生的结果文件:plink.ld

from collections import defaultdict
import pandas as pd

#input
ld_f="ind_sig_snp_LD_win1000.ld"
#output
output="loci_of_ind_sig_snp.txt"

d=defaultdict(list)
with open(ld_f,'r') as f:
    for line in f:
        if not line.startswith(" CHR_A"):
            line=line.strip().split()
            d[line[2]].append(line[4])

with open(output,'w') as f:
    print("%s\t%s\t%s\t%s" %("CHR","GWAS_loci","start","end"),file=f)
    for keys,value in d.items():
        print("%s\t%s\t%s\t%s" %(keys[0:8],keys,min(value),max(value)),file=f)

