#用于合并相邻较近的两个LD blocks
import pandas as pd

#loci list,formate:CHR、loci id、start、end
loci="../snp_ld_block2.txt"
#两个区间相距多远就会合并,单位：bp
dist=900000

f=pd.read_csv(loci,sep='\t') 
def merge(f,dist_list):
    def get_dist_list():
        return(dist_list)
    for i in range(1,len(f)):
        d=int(f.iloc[i,2])-int(f.iloc[i-1,3])
        if f.iloc[i,0]==f.iloc[i-1,0] and d <= int(dist) and f.iloc[i,2]>=f.iloc[i-1,2]:
            left = min(f.iloc[i,2],f.iloc[i-1,2])
            right = max(f.iloc[i,3],f.iloc[i-1,3])
            f.iloc[i-1,2] = f.iloc[i,2]=left
            f.iloc[i-1,3] = f.iloc[i,3]=right
            if d>0:
                dist_list.append(d)   
        else:
            continue
    return(f,dist_list)

n=1
while True:
    dist_list=[]
    merge(f,dist_list)
    if not dist_list:
        print("end")
        break
    else:
        print(n,len(dist_list))
        n+=1
f.to_csv('snp_ldbock_merged_dist900k.txt',header=1,sep='\t',index=False)

