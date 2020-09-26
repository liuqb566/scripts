
Ref=/home/liuqb/data/genome/Cotton/HAU1.0/HAU_genome.fa
while read id
do 
#nohup \
ls ${id}*.bam|xargs -I [] echo "I="[]|xargs -L 100 \
picard MergeSamFiles \
O=${id}.merged.sorted.bam \
SORT_ORDER=coordinate \
CREATE_INDEX=true \
VALIDATION_STRINGENCY=LENIENT \
REFERENCE_SEQUENCE=$Ref
TMP_DIR=./tmpdir 2>${id%}.log \
#&
done <$1
