#!/bin/bash
#由于 bed 格式的 fam 文件中，individul id 排序不正常，所以在加入 phenotype 的时候要注意排序。
#fam_first_5.txt 文件：fam 文件的前 5 列
#fam_sort.txt 文件：自悟
#history：
# 2017-12-11 v1 gossie

# phenotype 文件，有表头，第一列为 id
phe="02ave_blup.txt"


# 进行转换
cut -f2- ${phe} | \
tail -n +2| \
paste fam_sort.txt  -| \
sort -nk 1| \
cut -f3-| \
paste fam_first_5.txt - \
>355_ms_0.4.fam.${phe%%.*}.bk

