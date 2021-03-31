# About 

This repo presents some of the basic functionality for using `Picotte` on [Drexel University's Research Computing Facility (UCRF)](http://www.drexel.edu/research/urcf/). Proteus uses the [Slurm workload manager](https://slurm.schedmd.com/overview.html) as the job scheduler to handle jobs. For more information, please refer to [Migrating to Picotte](https://proteusmaster.urcf.drexel.edu/urcfwiki/index.php/Migrating_to_Picotte). 

# Login
First, you need to make sure that you are connected to Drexel network or [Drexel VPN](https://drexel.edu/it/help/a-z/VPN/)
Second, you can use ssh to login to Picotte in your shell. If your computer runs a macOS system or a linux system, you should be able to open the terminal and run bash command. If your computer runs a windows system, I would suggest you either enable the [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install-win10) so that you get access to a terminal or download a SSH client, for example, [PuTTY](https://www.putty.org/).
The following command shows how to "ssh" into Picotte.
```bash
  # sshing into Picotte
  ssh $USERNAME@picottelogin.urcf.drexel.edu
```
`$USERNAME` should be your drexel id (in abc123 format) used to login your one.drexel.edu account.

# Using Modules
There are numerous softwares installed on Picotte already. Before you install any software on your own, run the following command to see a list of modules available in Picotte which you can directly load and run in your job script.
```bash
module avail
```
Once you have found the module that you want to load, let's say you want to load the anaconda3 distribution of python and run a python3 script, you can add the following command in your job script (I will get into the concept job script in the next section).
```bash
module load python/anaconda3
```
You can also check the modules that have been loaded by
```bash
module list
```
You can not run any computationally expensive commands directly in the terminal once you logged in Picotte. For example, it is ok to run `module avail` in the terminal directly to see a list of modules. It is also ok to run some basic bash commands such as `ls` to manage your files. However, DO NOT run any python scripts or copy a large file from one directory to another in the terminal. Instead, you should write a job script and submit it to Picotte so that Picotte can assign a computing node to complete your task. In the next section, I will show you how to write and submit a job script to get your work done.

# Writing a job script
1. The first question you need to ask yourself is that what partition you want your job script to be submitted to. There are 5 partitions on Picotte, corresponding the 3 different classes of nodes:
> def - default partition, containing 74 standard compute nodes (48 cores, 192 GB RAM); if you do not specify a partition, this is the one that will be used
>
> long - standard compute nodes, used for long jobs (wall clock time <= 192 hours)
>
> gpu - 12 GPU nodes (48 cores, 192 GB RAM, 4x Nvidia Tesla V100 for Nvlink)
>
> gpulong - GPU nodes, used for long jobs (wall clock time <= 192 hours)
>
> bm - 2 big memory nodes (48 cores, 1.5 TB RAM) - wall clock time <= 504 hours
Most of the time, the default partition is good enough for you to run your job. But in case your job need more wall clock time and/or more memory, you can submit to long/bm nodes instead.

2. Second, you need to consider if your job needs a lot of I/O operations, i.e., load/write data from/to the disk frequently. In those cases, you want to change the output directory in your command to Fast parallel scratch (you need to create a directory in `/beegfs/scratch`, write to the fast scratch space and copy the data to your own directory or the group folder when the job is done). This process depends on the software you are running, so this step is something you need to consider yourself and there is no universal solution.

3. Then you can consider the modules that you want to load and the commands you want to run. You can keep the commands in a separate file and execute that file in your job script. Or, if there are only a few commands to run, you can just keep it in the job script. Here, I adapted a job script template from the Picotte wiki page. This job script template prints out the python version as an example. The job script has a header section used to specify the partition information, run time etc. You should read the comment left in the template to understand the header section. You at least need to change the email address in this job script to your drexel email and the account to the account associated with this class (you will need to consult with the instructor for the account information).
```bash
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
### request 15 minutes of wall clock time (if you request less time, you can wait for less time to get your job run by the system, you need to have a good esitmation of the run time though).
#SBATCH --time=00:15:00
### memory size required per node (this is important, you also need to estimate a upper bound)
#SBATCH --mem=10GB
### select the partition "def" (this is the default partition but you can change according to your application)
#SBATCH --partition=def


### Whatever modules you used (e.g. picotte-openmpi/gcc)
### must be loaded to run your code.
### Add them below this line.

module load python/anaconda3

### The commands you want to run in this job script (run a python script, run a certain software with inputs and outpus etc.).
python -V
```

4. Once you get the job script ready, you can submit it to the system using the following command:
```bash
sbatch $JOBSCRIPTNAME
```
where `$JOBSCRIPTNAME` is the name of your job script, e.g., `template_job_script.sh`


5. To check the status of your job, there are several commands that are helpful
* squeue is used to report the state of jobs or job states (pending or running jobs).
```bash
squeue -u $USERNAME
```
where $USERNAME is your drexel account in adc123 format.
* In case you get some error message or your software doesn't give you expected outcome, you can run ``seff'' to check the statistics of the job such as the memory used.
```bash
seff $JOBID
```
where $JOBID is the job id associated with your job script (a few digits number). Usually, you will see a output file created by slurm when your job script is excuted by the system. The file looks like ``slurm-$JOBID.out``. For example, if the output file is ``slurm-12345.out'', the job id would be 12345.
* For more information, check the [slurm page](https://proteusmaster.urcf.drexel.edu/urcfwiki/index.php/Slurm_Quick_Start_Guide#Overview). 

6. It can still be tough to debug your code because you don't have instant feedback. I would recommend you to use an interactive session. Once the interative session is activated, you can directly run commands in your terminal. However, it is not a good practice to run commands that runs for too long in the interactive session because your terminal not got terminated by your OS due to, e.g., the screensaver process. If you are interested in this feature, please refer to [Interactive Terminal Sessions on Compute Nodes](https://proteusmaster.urcf.drexel.edu/urcfwiki/index.php/Interactive_Terminal_Sessions_on_Compute_Nodes).

7. For more advanced usage, please go over [Writing Slurm Job Scripts](https://proteusmaster.urcf.drexel.edu/urcfwiki/index.php/Writing_Slurm_Job_Scripts) and [A list of job script examples](https://proteusmaster.urcf.drexel.edu/urcfwiki/index.php/Category:Examples).

# New to BASH?
Bash programming is essential for you to navigate and manage your files/directoroes in Picotte. If you are interested in a [Bash tutorial](https://nbviewer.jupyter.org/github/gditzler/bio-course-materials/blob/master/notebooks/Bash-Tutorial.ipynb), please go ahead and go over it.


