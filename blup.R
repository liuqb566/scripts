#!/usr/bin/Rscript --vanilla

# 用于计算 blup 和遗传力
# 每次仅能对一个表型进行 blup 运算，可以通过 num 参数控制
# 需要先安装 lme4 包
# 注意: 与 shell 脚本不同，R 脚本运行过程中，不能修改运行脚本
# 感谢软件开发者和[文子的博客](http://blog.sina.com.cn/s/blog_4b55f41301018gtv.html)
# history:
#    2017-12-21 v1 Gossie


# 工作目录路径
workspace <- "~/workspace/research/实验数据/SPAD数据整理/" 
# lme4 文件 header：Line（材料）、Loc（地点）、Rep（重复）、Year、Phe（表型）... 
# Line、Loc、Rep、Year 四列可以根据实际情况增减，但是表头名字不能变；Phe 列后可以根多个表型，可以自主命名。如果有多个表型，通过更改 num 参数决定对哪一个表型进行分析。
input <- "/home/liuqibao/workspace/research/实验数据/SPAD数据整理/lme4格式_spad.txt"

# 输出文件
output <- "delta_spad_blup.txt"
# 此次分析的表型位于第几列
num=7


setwd(workspace)
f <- read.table(input,header = 1,na.strings = NA)

# 没有的水平就注释掉, 同时选择相应的模型
Loc <- as.factor(f$Loc)
Year <- as.factor(f$Year)
#Rep <- as.factor(f$Rep)
Line <- as.factor(f$Line)
Phe <- as.numeric(f[,num])

library(lme4)

#原模型 phemodel = lmer(Phe ~ 1+(1|Line) + (1|Loc) + (1|Year) + (1|Rep%in%Loc:Year)+ (1|Line:Loc) + (1|Line:Year)) 
#已省略 1+，代表随机效应;
#由于 bug 问题删除了 (1|REP%in%LOC:YEAR) 项。
#或者可以通过 options(lmerControl=list(check.nobs.vs.rankZ = "warning",check.nobs.vs.nlev = "warning",check.nobs.vs.nRE = "warning",check.nlev.gtreq.5 = "warning",check.nlev.gtr.1 = "warning")) 命令通过检验。一般差别不大，但是如果重复间差异很大，需要特别注意。

# 选择适合的模型
#BLUPS（多年多点）
phemodel = lmer(Phe ~ (1|Line) + (1|Loc) + (1|Year) + (1|Line:Loc) + (1|Line:Year))
## BLUPS（一年多点）
#phemodel = lmer(Phe ~ (1|Line) + (1|Loc) + (1|Line:Loc))
## BLUPS（一点多年）
#phemodel = lmer(Phe~ (1|Line)  + (1|Year) + (1|Line:Year))

# Extract variance components
###########################################################################################
#Estimation narrow sense heritability
#Heritability = var(Line)/[ var(Line) + var(Line:Loc)/a + var(Line:Year)/b + var(RESIDUAL)/(ab)]
#var(Line), var(Line:Loc), var(Line:Year), var(RESIDUAL): variance of Line, Line:Loc, Line:Year, RESIDUAL
#a: number of Loc levels
#b：number of Year levels

summary_out <- paste(output, "summary",sep=".")
sink(summary_out)
summary(phemodel)
sink()

# estimate BLUPS
pheblup <- ranef(phemodel)
# extract blup for line
phelineblup = pheblup$Line
# save the brixlineblup output to a separate .csv file
write.table(phelineblup, file=output)

#还可以用 blup 矫正表型
#phe_blup <-fixef(phemodel) + phelineblup 
