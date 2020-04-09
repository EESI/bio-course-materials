#!/bin/bash
# tell SGE to use bash for this script
#$ -S /bin/bash
# execute the job from the current working directory, i.e. the directory in which the qsub command is gi$
#$ -cwd
# set email address for sending job status
#$ -M fixme@drexel.edu
# project - basically, your research group name
#$ -P rosenclassGrp
# This creates an array job that has 100 processes
#$ -t 1-100:1
# request 15 min of wall clock time "h_rt" = "hard real time" (format is HH:MM:SS, or integer seconds)
#$ -l h_rt=00:15:00
# a hard limit 1 GB of memory per slot - if the job grows beyond this, the job is killed
#$ -l h_vmem=8G
# want at least 6 GB of free memory
#$ -l mem_free=1G
# select the queue all.q, using hostgroup @intelhosts
#$ -q all.q@@intelhosts

. /etc/profile.d/modules.sh
module load shared
module load proteus
module load sge/univa
echo "The Task ID is: ", $SGE_TASK_ID
