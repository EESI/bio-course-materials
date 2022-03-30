#!/bin/bash
#
### !!! CHANGE !!! the email address to your drexel email
#SBATCH --mail-user=glr26@drexel.edu
### !!! CHANGE !!! the account - you need to consult with the professor
#SBATCH --account=eces450650Prj
### select number of nodes (usually you need only 1 node)
#SBATCH --nodes=1
### select number of tasks per node
#SBATCH --ntasks=27
### select number of cpus per task (you need to tweak this when you run a multi-thread program)
#SBATCH --cpus-per-task=1
### request 15 minutes of wall clock time (if you request less time, you can wait for less time to get your job run by the system, you need to have a good esitmation of the run time though).
#SBATCH --time=00:10:00
### memory size required per node (this is important, you also need to estimate a upper bound)
#SBATCH --mem=1GB
### select the partition "def" (this is the default partition but you can change according to your application)
#SBATCH --partition=def
### Set the number of array tasks that you want to spawn from this job.
#SBATCH --array=0-26
### Set a parameter that will rerun the code if the queue gets interrupted
#SBATCH --requeue

# run this file by executing the name and piping out to file, e.g.: ./get_16S_from_pyogenes.sh > rRNAs_v2.fna

declare -a GENES=("NS7a" "Spike" "NSP11" "NSP10" "NS6" "NSP2" "N" "E" "NSP12" \
"NSP4" "NS8" "NSP1" "NSP6" "NSP9" "NSP5" "NSP3" "NS9b" "NSP14" "NSP7" "NSP15" \
"NS3" "NSP13" "NS7b" "NSP8" "NSP16" "NS9c" "M")

#Assign the Accession ID of the genome to a variable
echo "${GENES[$SLURM_ARRAY_TASK_ID]}"
