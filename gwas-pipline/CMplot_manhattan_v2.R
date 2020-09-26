#!/usr/bin/Rscript --vanilla
# 需要先安装 CMplot 包
# 注意: 与 shell 脚本不同，R 脚本运行过程中，不能修改运行脚本

# 工作目录路径
workspace <- "/home/liuqibao/workspace/research/chl_数据处理/355材料/GWAS_355/gemma_based/SLAF_ms_0.4/output"
#CMplot 参数
#颜色
#col <- c("dodgerblue1","darkgoldenrod1")
col <- c("grey30","grey60")
#Manhattan 图类型：m（方形），c（圆形），q（QQ图），d（SNP 标记密度图）
type <- c("m","q")
# 阈值线:0.01, 0.05, 0.1, 1等，或者c(0.01,0.05)同时画多条
thsh <- c(1,10)
# 如果有多个阈值，可以分别设定阈值线，参数 threshold.col=C("red","oragne")
thsh.col <- c('red','green')
# SNP 个数,用于计算阈值，可以自己指定，可以让程序自己计算
num <- 92812

setwd(workspace)

# 匹配所有cmplot格式的文件，这个后缀来自脚本 transform_gemma_result_to_cmplot_formate_v2.sh ,其它匹配模式自行设定。
files <- dir(pattern = "^[1-9].*cmplot.txt")

##问题：加上阈值后不显颜色
library(CMplot)
for (i in files){
  print(i)
  # CMplot 格式文件：SNP、CHR、PS、Phe...
  f <- read.table(i,header=1)
  # threshold 参数的完整格式是 threshold=c(0.01,0.1,1)/nrow(f), 简写成 threshold=0.1 有时会出问题
  # num <- nrow(f)
  CMplot(f,col=col,plot.type = type,threshold.col=thsh.col,threshold=thsh/92812)

  # 画 SNP 标记密度，一次就可以,但是对于gemma的结果，如果表型有缺失值，会导致软件自动排除缺失个体，导致标记变少
  #CMplot(pvalue[1:4],plot.type = "d")
}

