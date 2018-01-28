#!/usr/bin/Rscript --vanilla
# 需要先安装 CMplot 包
# 注意: 与 shell 脚本不同，R 脚本运行过程中，不能修改运行脚本


# 工作目录路径
workspace <- "/home/liuqibao/workspace/research/chl_数据处理/355材料/GWAS_355/gemma_based/SLAF_ms_0.4/output"

# CMplot 格式文件：SNP、CHR、PS、Phe...
input <- "浓度_pvalue_ms0.4_maf0.05.txt"
#CMplot 参数
#颜色
col <- c("dodgerblue1","darkgoldenrod1")
#Manhattan 图类型：m（方形），c（圆形），q（QQ图），d（SNP 标记密度图）
type <- c("m","q")
# 阈值线:0.01, 0.05, 0.1, 1等，或者c(0.01,0.05)同时画多条
thsh <- 1
# 如果有多个阈值，可以分别设定阈值线颜色,参数 threshold.col=c("red","orange")
# thsh.col <- c("red","green")

library(CMplot)
setwd(workspace)
pvalue <- read.table(input,header = 1)
for(i in 4:dim(pvalue)[2]){CMplot(pvalue[c(1:3,i)],col= col,plot.type = type,threshold = thsh/nrow(pvalue)}

# 画 SNP 标记密度，一次就可以
#CMplot(pvalue[1:4],plot.type = "d")
