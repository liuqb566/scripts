#!/bin/bash
#由于 bed 格式的 fam 文件中，individul id 排序不正常，所以在加入 phenotype 的时候要注意排序。
#本脚本适用于用 individul id 用数字表示的情况
#history：
# 2017-12-11 v2 gossie

# phenotype 文件，有表头，第一列为 id
phe="185总.txt"
# fam 文件
fam="185_geno0.4_maf0.05.fam"

# 抽取表型值，去掉 header
cut -f2- ${phe} | \
  tail -n +2 >tmp.txt

# 重新排序
cut -d ' ' -f1-5 ${fam} |\
  nl |\
    sort -nk 2 |\
      paste - tmp.txt |\
        sort -nk 1 |\
          cut -f2- >${fam}.${phe%%.*}.bk

rm tmp.txt
