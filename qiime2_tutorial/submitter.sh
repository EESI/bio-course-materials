#!/bin/bash
#
### !!! CHANGE !!! the email address to your drexel email
#SBATCH --mail-user=abc123@drexel.edu
### !!! CHANGE !!! the account - you need to consult with the professor
#SBATCH --account=eces450650Prj
### select number of nodes (usually you need only 1 node)
#SBATCH --nodes=1
### select number of tasks per node
#SBATCH --ntasks=1
### select number of cpus per task (you need to tweak this when you run a multi-thread program)
#SBATCH --cpus-per-task=32
### request 48 hours of wall clock time (if you request less time, you can wait for less time to get your job run by the system, you need to have a good esitmation of the run time though).
#SBATCH --time=0:15:00
### memory size required per node (this is important, you also need to estimate a upper bound)
#SBATCH --mem=32GB
### select the partition "def" (this is the default partition but you can change according to your application)
#SBATCH --partition=def

newgrp eces450650Grp
containerdir=/qiime2_tutorial
SINGULARITYENV_containerdir=${containerdir} singularity exec --bind .:/${containerdir} /ifs/groups/eces450650Grp/containers/qiime bash ${containerdir}/qiime_tutorial.sh
