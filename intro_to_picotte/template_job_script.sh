#!/bin/bash
#
### !!! CHANGE !!! the email address to your drexel email
#SBATCH --mail-user=abc123@drexel.edu
### !!! CHANGE !!! the account - you need to consult with the professor
#SBATCH --account=rosenclassPrj
### select number of nodes (usually you need only 1 node)
#SBATCH --nodes=1
### select number of tasks per node
#SBATCH --ntasks=1
### select number of cpus per task (you need to tweak this when you run a multi-thread program)
#SBATCH --cpus-per-task=1
### request 48 hours of wall clock time (if you request less time, you can wait for less time to get your job run by the system, you need to have a good esitmation of the run time though).
#SBATCH --time=48:00:00
### memory size required per node (this is important, you also need to estimate a upper bound)
#SBATCH --mem=12GB
### select the partition "def" (this is the default partition but you can change according to your application)
#SBATCH --partition=def


### Whatever modules you used (e.g. picotte-openmpi/gcc)
### must be loaded to run your code.
### Add them below this line.

module load python/anaconda3

### The commands you want to run in this job script (run a python script, run a certain software with inputs and outpus etc.).
python -V
