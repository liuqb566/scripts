
while read id
do
RG=${id#*.}
SM=${id%.*}
echo $RG $SM
#nohup \
picard AddOrReplaceReadGroups \
I=${id}.sam \
O=${id}.bam \
RGID=${RG} \
RGLB=${SM} \
RGPL=illumina \
RGPU=${RG}_${SM} \
RGSM=${SM} \
#&

done <$1

