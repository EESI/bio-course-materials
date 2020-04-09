#!/bin/bash
# tell SGE to use bash for this script
#$ -S /bin/bash
# execute the job from the current working directory, i.e. the directory in which the qsub command is given
#$ -cwd
# set email address for sending job status
#$ -M fixme@drexel.edu
# project - basically, your research group name with "Grp" replaced by "Prj"
#$ -P fixmePrj
# select parallel environment, and number of job slots
#$ -t 1-100:1
# request 15 min of wall clock time "h_rt" = "hard real time" (format is HH:MM:SS, or integer seconds)
#$ -l h_rt=00:15:00
# a hard limit 8 GB of memory per slot - if the job grows beyond this, the job is killed
#$ -l h_vmem=8G
# want at least 6 GB of free memory
#$ -l mem_free=6G
# select the queue all.q, using hostgroup @intelhosts
#$ -q all.q@@intelhosts 

module load python/2.7.6
python -c "print 'The task ID is $SGE_TASK_ID'""

