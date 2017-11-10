blup<-function(phenotype_df){
  library(lme4)
  attach(phenotype_df)
  phenotype_name<-as.numeric(phenotype_df[,5])
  LINE<-as.factor(Var)
  LOC<-as.factor(Loca)
  YEAR<-as.factor(year)
  REP<-as.factor(rep)
  name_varcmp<-paste(names(phenotype_df)[5],"varcomp",sep = "")
  name_varcmp = lmer(phenotype_name~ (1|LINE) + (1|LOC) + (1|YEAR) + (1|REP %in% LOC:YEAR) + (1|LINE:LOC) + (1|LINE:YEAR),
                   control=lmerControl(check.nlev.gtr.1 = "ignore"))
  name_model<-paste(names(phenotype_df)[5],"model",sep = "")
  name_model<-lmer(phenotype_name~ (1|LINE) + (1|LOC) + (1|YEAR) + (1|REP %in% LOC:YEAR) + (1|LINE:LOC) + (1|LINE:YEAR),
                 control=lmerControl(check.nlev.gtr.1 = "ignore"))
  name_blup<-paste(names(phenotype_df)[5],"blup",sep = "")
  name_blup<-ranef(name_model)
  name_lineblup<-paste(names(phenotype_df)[5],"lineblup",sep = "")
  name_lineblup<-name_blup$LINE
  result<-paste(names(phenotype_df)[5],"blup.txt",sep = "")
  names(name_lineblup)<-c(names(phenotype_df)[5])
  write.table(name_lineblup,file=result,quote = F,row.names =T,sep="\t",col.names = T)
  detach(phenotype_df)
  name_hist<-paste("hist of",names(phenotype_df)[5])
  pdf(file = paste(name_hist,".pdf",sep=""))
  hist(name_lineblup[,1],main=name_hist,col="gray60",border="white",xlab="")
  dev.off()
  Heritabllity<-"Heritability = var(LINE)/[ var(LINE) + var (LINE:LOC)/2 + var(LINE:YEAR)/2 + var (RESIDUAL)/4]"
  Heritabllity
  summary(name_model)
} 