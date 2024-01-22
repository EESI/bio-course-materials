#!/bin/bash
#
### !!! CHANGE !!! the email address to your drexel email
#SBATCH --mail-user=youremail@drexel.edu
### !!! CHANGE !!! the account - you need to consult with the professor
#SBATCH --account=eces450650prj
### select number of nodes (usually you need only 1 node)
#SBATCH --nodes=1
### select number of tasks per node
#SBATCH --ntasks=1
### select number of cpus per task (you need to tweak this when you run a multi- thread program)
#SBATCH --cpus-per-task=1
### request 15 minutes of wall clock time (if you request less time, you can wai t for less time to ge t your job run by the system, you need to have a good esitm ation of the run time though).
#SBATCH --time=00:10:00
### memory size required per node (this is important, you also need to estimate a upper bound)
#SBATCH --mem=1GB
### select the partition "def" (this is the default partition but you can change according to your application)
#SBATCH --partition=edu

# run this file by executing the name and piping out to file, e.g.: ./get_16S_from_pyogenes.sh > rRNAs_v2.fna

#Assign the Accession ID of the genome to a variable
singularity run --fakeroot --bind /ifs/groups/eces450650Grp/test_slurm/bio-course-materials/edirect_container_run_script:/run_script /ifs/groups/eces450650Grp/containers/edirect_latest.sif bash /run_script/rng_example.sh > rRNAs_v2.fna
