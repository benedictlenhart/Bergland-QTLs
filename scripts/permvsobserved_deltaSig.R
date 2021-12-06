#this figure compares the proportion of significant snps (snps with p value < 10e-5 / total snps on that chromosome) , showing the change in this statistic between GRM and no GRM, within both observed and permutated data. phenotypes shown are those with relatively high delta sig

setwd("/Users/supad/OneDrive/Documents/Bergland Research/R_data_objects/November_objects/")
library(tidyverse)
library(data.table)

###now repeat with delta sig
sigphenos = observed.data %>% 
  group_by(phenotype) %>% 
  summarise(meansig = mean(delta.sig))
sigphenos = as.data.table(sigphenos)
sigphenos = sigphenos[meansig >= 5.065e-06]

highsigdata = merge(highphenos, all.data, by = "phenotype")
###graph permutations vs observed in these high phenotypes
png("permvsobserved.deltasig.scaled.png")
ggplot(highsigdata[delta.sig < 2e-04], aes(y=reorder(phenotype,delta.sig, mean), x = Sig.number.x, color = factor(permutation))) +
  geom_point(alpha=0.5) +
  scale_color_manual(values = c("blue", "green")) +
  geom_hline(yintercept=0, linetype="dashed",
             color = "grey", size=1) +
  ylab("phenotypes") +
  xlab("(snps with p < 10e-5) / (# total snps) (nogrms-grms)") +
  theme_bw()+
  facet_grid(.~chromosome) +
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
        axis.text.y = element_text(size = 10)) +  #guides(color = "none")+
  guides(shape = guide_legend(ncol = 1))+
  labs(title = "", color = "Chrs")
dev.off()