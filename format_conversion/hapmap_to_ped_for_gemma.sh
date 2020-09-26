#!/bin/bash
plink=/home/liuqibao/myprogram/bio-tools/plink-1.07-x86_64/plink
hmp='cotton-dp5-miss0.2-maf0.05.geno.hmp'
#number of snp
n=3065432
#number of accessions
l=355
# prefix
prefix='test'

#genotype,截取genotype，等位基因间加空格，缺失值 - 改为 0
cut -f12- $hmp|tail -n +2 |sed 's/\([A-Z-]\)\([A-Z-]\)/\1 \2/g'|sed 's/-/0/g' >snp.txt
# snp name
cut -f1 $hmp|tail -n +2 >rs.txt
# chromosome
cut -f3 $hmp|tail -n +2 >chr.txt
# 染色体转换为数字
sed -i -e "s/\<A01\>/1/g" -e "s/\<A02\>/2/g" -e "s/\<A03\>/3/g" -e "s/\<A04\>/4/g" -e "s/\<A05\>/5/g" -e "s/\<A06\>/6/g" -e "s/\<A07\>/7/g" -e "s/\<A08\>/8/g" -e "s/\<A09\>/9/g" -e "s/\<A10\>/10/g" -e "s/\<A11\>/11/g" -e "s/\<A12\>/12/g" -e "s/\<A13\>/13/g" -e "s/\<D01\>/14/g" -e "s/\<D02\>/15/g" -e "s/\<D03\>/16/g" -e "s/\<D04\>/17/g" -e "s/\<D05\>/18/g" -e "s/\<D06\>/19/g" -e "s/\<D07\>/20/g" -e "s/\<D08\>/21/g" -e "s/\<D09\>/22/g" -e "s/\<D10\>/23/g" -e "s/\<D11\>/24/g" -e "s/\<D12\>/25/g" -e "s/\<D13\>/26/g" chr.txt

# position
cut -f4 $hmp|tail -n +2 >ps.txt
# genetic distance
for i in `seq 1 $n`
do
echo 0 >>ge.txt
done
# 构建tped文件
paste chr.txt rs.txt ge.txt ps.txt snp.txt >trans.tped

# 构建tmap文件：Family ID,individual ID,paternal ID,maternal ID,sex,phenotype

head -n1 $hmp|cut -f12-|tr '\t' '\n' >line.txt
for i in `seq 1 $l`
do
echo 0 >>tmp.txt
echo $i >>phe.txt
done

paste line.txt line.txt tmp.txt tmp.txt tmp.txt phe.txt >trans.tfam

#translate to ped formats
$plink --noweb --tfile trans --recode --tab --out $prefix
