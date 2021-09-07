###gather snp information about requested snps###

library(tidyverse)
library(data.table)
library(foreach)
out <- foreach(f = c(1:90)) %do% {
  
  filepath <- paste("/scratch/bal7cg/wolstarv-permutations/" , "perm", f, sep = "")
  dt <- fread(filepath)#load in 1 of the permutations
  #load in top snps
 # top <- readRDS("/home/bal7cg/R/data.objects/summer_project/top.snps")
  ###filter data in same way as test data###
  #resupply column names to dt
  
  colnames(dt) <- c("SNP",  "CHR"  ,   "POS",  "REF", "ALT" ,"N","MISSRATE", "AF"   ,    "SCORE" ,   "VAR"   ,   "PVAL")
  #filter out snps with high missrate
  common.snps <- dt[MISSRATE < 0.15]#3,200,000 variants
  #remove snps with missing PVaL
  common.snps <- common.snps[is.na(common.snps$PVAL) == F]#still 3,200,00 variants
  #common.snps$Pval.scaled <- -log10(common.snps$PVAL)
  commons.snps = common.snps[common.snps$AF > 0.05]
  #common.snps$PVal.corr <- p.adjust(common.snps$PVAL, "fdr")
  #see if we can append data of interest into a meta file
  short.data <- common.snps %>% 
    select(CHR, POS, PVAL) %>% 
    mutate(perm = f)
  
  #filter to top snps
  # filtered.snps <- common.snps %>%
  #   .[ which(POS %in% top$POS ),] %>%
  #   mutate(perm = f)
  # filtered.snps <- as.data.table(filtered.snps)
  
  return(short.data)
}

  short_out <- rbindlist(out)
saveRDS(short_out,"/home/bal7cg/R/data.objects/summer_project/starv.perm.gather")
