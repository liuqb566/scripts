#需要samtools 1.10以上

while read id
do
ID=${id#*.}
sample=${id%.*}
TAG="@RG\tID:${ID}\tSM:${sample}\tLB:${sample}\tPL:illumina"
samtools addreplacerg -@ 20 -r ${TAG} ${id}.sam |samtools sort -@ 20 -O bam -o ${id}.sorted.bam 
done < $1
