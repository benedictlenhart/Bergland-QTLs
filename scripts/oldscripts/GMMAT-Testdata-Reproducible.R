#!/usr/bin/env Rscript
# HEADER --------------------------------------------
#
# Author: Adam Lenhart, PHD
# 
# Email:  bal7cg@virginia.edu
# 
# Date: June 2, 2021
#
# Script Name: GMMAT-TestData-R
#
# Script Description: Run GMMAT on dgrp data, shuffling the line ids with seed = permutation number
#
#
# Notes: DGRP genetic data and phenotype data from a past experiment. 
#
#

# allow user to pass inputs

args = commandArgs(trailingOnly=TRUE)
#create job id from array
jobid <- args[1]
#Path to the GDS file
ingds=args[2]
#Path to the GRM
GRM=args[3]
#path of the outfile to be appended here
outpath=args[4]
phenotype.tag = args[5]
#load libraries
#library(SeqArray)
#library(tidyverse)
library(GMMAT)
library(data.table)

#load in grm
GRM <- readRDS(GRM)


#load phenotype data table
traitdata <- readRDS("/home/bal7cg/R/data.objects/summer_project/pheno.wol")
#filter out phenotype of interest, and only females
pheno <- traitdata[phenotype == phenotype.tag][sex == "F"]


#fit a GLMM to the data
modelqtl <- glmmkin(fixed =avg ~ wol.status, data = pheno, kins = GRM, id = "fitid",family = gaussian(link = "identity"))

#run GMMAT
outfile = paste(outpath,phenotype.tag, "testdata", sep = "")
glmm.score(modelqtl, infile = ingds, outfile = outfile, MAF.range = c(0.05,0.5), miss.cutoff = 0.15)
