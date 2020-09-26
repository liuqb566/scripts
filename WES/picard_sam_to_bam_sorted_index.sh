

while read id
do 
#nohup \
picard SortSam \
I=${id}.sam \
O=${id}.sorted.bam \
SORT_ORDER=coordinate \
CREATE_INDEX=true \
VALIDATION_STRINGENCY=LENIENT \
TMP_DIR=./tmpdir 2>${id}.log \
#&
done <$1
