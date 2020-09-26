
plink=plink
#plink格式文件,最好缺失表型，否则HV模式会要求有case/control phenotype
plink_format=ms0.2-maf0.05-mis-phe
#目的SNP的上下游长度，单位kb
window=1000

haplowview=/home/liuqb/tools/Haploview.jar

while read id
do
#$plink -bfile $plink_format --snp $id --window $window --recode HV --out $id && \
java -jar $haplowview -nogui -skipcheck -pedfile $id.chr-*.ped -info $id.chr-*.info -out $id -log -blockoutput GAB
done <$1


