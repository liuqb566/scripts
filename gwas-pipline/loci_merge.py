#用于合并相邻较近的两个LD blocks
import pandas as pd

#loci list,formate:CHR、loci id、start、end
loci="loci_of_ind_sig_snp.txt"
#两个区间相距多远就会合并,单位：bp
dist=200000

f=pd.read_csv(loci,sep='\t')
for i in range(1,len(f)):
    d=int(f.iloc[i,2])-int(f.iloc[i-1,3])
    if f.iloc[i,0]==f.iloc[i-1,0] and d < int(dist):
        f.iloc[i,2]=f.iloc[i-1,2]
        f.iloc[i-1,3]=f.iloc[i,3]
    else:
        continue

f.to_csv('loci_merged.txt',header=0,sep='\t',index=False)
