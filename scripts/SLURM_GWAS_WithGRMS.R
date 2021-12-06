#!/usr/bin/env bash
#
###goal, creat a slurm script that permutes gmmat for different phenotypes
#SBATCH -J gwas_nogrm # A single job name for the array
#SBATCH -c 4
#SBATCH -N 1 # on one node
#SBATCH -t 3:00:00 #<= this may depend on your resources
#SBATCH --mem 80G #<= this may depend on your resources
#SBATCH --mail-type=end
#SBATCH --mail-user=bal7cg@virginia.edu
#SBATCH -o /scratch/bal7cg/score_error/nogrm.%A_%a.err # Standard error
#SBATCH -e /scratch/bal7cg/score_output/nogrm.%A_%a.out # Standard output
#SBATCH -p standard
#SBATCH -A berglandlab_standard
### sbatch --array=2-42 /scratch/bal7cg/Yang_Adam/SLURM_GWASPerms_WithGRMS_101221.R
###this is the sbatch command to be used in terminal. array length = number of tasks in permutation or observed task id file, path = path to this file.


module load goolf/7.1.0_3.1.4
module load gdal proj R/4.0.0
module load intel/18.0 intelmpi/18.0
                    
                    
                    
                    jobid=${SLURM_ARRAY_TASK_ID}
                    wd="/scratch/bal7cg/Yang_Adam/" #working directory
                 
                    Rscript \
                    ${wd}GWASPerms_WithGRMS.R \
                    #the array task id is given to the R script as a variable
                    ${jobid} 









#squeue -u yy3ht
#scancel -u yy3ht


