#!/usr/bin/Rscript --vanilla
# 需要先安装 CMplot 包
# 注意: 与 shell 脚本不同，R 脚本运行过程中，不能修改运行脚本

# 工作目录路径
workspace <- "/home/liuqibao/workspace/research/chl_数据处理/355材料/GWAS_355/gemma_based/SLAF_ms_0.4/output"
file=
format='csv'
genotypes=c('a','h','b')
alleles=c('a','b')

setwd(workspace)
library(qtl)
f <- read.cross(file=file,format=format,genotypes=genotypes,alleles=alleles)
rf <- est.rf(f)
chAll <- checkAlleles(f,threshold=5)
