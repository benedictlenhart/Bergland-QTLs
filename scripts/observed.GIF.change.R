
#this figure shows the change in genomic inflation factor between observed gwas scores, amongst the old and new phenoptyes

setwd("/Users/supad/OneDrive/Documents/Bergland Research/R_data_objects/November_objects/")
library(tidyverse)
library(data.table)

#bring in combined data gathers
all.data = readRDS("allgatheredgwasstats")
#remove missing rows
all.data = na.omit(all.data)
observed.data = all.data[permutation == "observed"]
png("gwas.inflation.observed.png")

ggplot(observed.data, aes( y=reorder(phenotype,delta.GIF, mean), x= delta.GIF, color = chromosome)) +
  
  
  geom_point(alpha=1) +
  geom_vline(xintercept=0, linetype="dashed",
             color = "grey", size=1) +
  xlab("Delta.GIF (nogrms-grms)") +
  ylab("Phenotypes") +
  facet_grid(.~chromosome) +
  theme_bw()+
  theme(axis.line = element_line(colour = "black"),panel.background = element_blank())+
  theme(legend.title = element_text(size = 9),
        legend.text = element_text(size = 9),
        legend.position=c(0.95,0.95),
        legend.key.size = unit(0.3, "mm"),
        plot.title = element_text(size=10),
        strip.text.x = element_text(size = 12),
        strip.text.y = element_text(size = 10),
        axis.title=element_text(size=12,face="bold"),
        axis.text.x = element_text(angle = 90,hjust = 1, vjust = 1, size = 8),
        axis.text.y = element_text(size = 5)) +  #guides(color = "none")+
  guides(shape = guide_legend(ncol = 1))+
  labs(title = "", color = "pheno.group")
dev.off()