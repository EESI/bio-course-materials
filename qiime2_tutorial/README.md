# Getting Started

First, download the Git repo to you home folder on the login node of Proteus. Before we can run anything we need to configure a few things. Let us download the code and data from Github. 

```bash
  # Assuming you have ssh'd into the head node and are in your
  # home folder. Run 'pwd' without the ticks. You should see
  # /home/<your user name>. Then run:
  git clone https://github.com/z2e2/qiime2_tutorial.git
  cd qiime2_tutorial/
```

Now that we have the code, you must edit `submitter.sh`. Use `nano` to edit the following

* Change the email address in line 4 to be your Drexel email address (i.e., the username you would use to ssh into the cluster)

# What are we doing here?

This tutorial goes over how to use Qiime2 to process data from a high-throughput 16S rRNA sequencing studie collected from *Caporaso JG et al., 2011*. The original tutorial can be found [here](https://docs.qiime2.org/2019.1/tutorials/moving-pictures/). Here, we will learn how to use Qiime2 installed on Proteus.  Before getting started, lets point a few things out: 

* `emp-single-end-sequences/` contains the sequences and barcodes file (*.fastq.gz).
* `sample-metadata.tsv` contains metadata (subject info, barcode, body site, etc)
* `submitter.sh` is the script we're going to submit to SGE

# Submitting to the Proteus cluster

You need to make sure you change from your group to the courses group before you submit your job to the queuing system. This is true for any job that you run. Once you have changed your group, run: 

```bash 
  newgrp rosenclassGrp
  qsub submitter.sh
```

Use the `qstat` command to check the status of the job. SGE produces two files, an error and output file, in the directory where the script was submitted into the queue. Runnign `qstat` should give you something like 

```bash 
[zz374@proteusi01 qiime2_tutorial]$ qstat
job-ID  prior   name       user         state submit/start at     queue                          jclass                         slots ja-task-ID 
------------------------------------------------------------------------------------------------------------------------------------------------
 530147 0.00500 submitter. zz374        r     4/16/2019 12:30:00 all.q@ic22n03.cm.cluster                                          1        
```

where the `r` lets us know the code is running. 

You can check the file contents for any errors or things that would have normally been dumped to the standard output. Check the `core-metrics-results/` folder for more contents of the Qiime output being executed in `submitter.sh` 

```bash
[zz374@proteusa01 qiime2_tutorial]$ ls -hl core-metrics-results/
total 6.6M
-rw-r--r-- 1 zz374 rosenclassGrp  55K Apr 12 16:15 bray_curtis_distance_matrix.qza
-rw-r--r-- 1 zz374 rosenclassGrp 776K Apr 12 16:15 bray-curtis-emperor-DaysSinceExperimentStart.qzv
-rw-r--r-- 1 zz374 rosenclassGrp 776K Apr 12 16:15 bray_curtis_emperor.qzv
-rw-r--r-- 1 zz374 rosenclassGrp  65K Apr 12 16:15 bray_curtis_pcoa_results.qza
-rw-r--r-- 1 zz374 rosenclassGrp 314K Apr 12 16:15 evenness-group-significance.qzv
-rw-r--r-- 1 zz374 rosenclassGrp  52K Apr 12 16:15 evenness_vector.qza
-rw-r--r-- 1 zz374 rosenclassGrp 315K Apr 12 16:15 faith-pd-group-significance.qzv
-rw-r--r-- 1 zz374 rosenclassGrp  52K Apr 12 16:15 faith_pd_vector.qza
-rw-r--r-- 1 zz374 rosenclassGrp  56K Apr 12 16:15 jaccard_distance_matrix.qza
-rw-r--r-- 1 zz374 rosenclassGrp 776K Apr 12 16:15 jaccard_emperor.qzv
-rw-r--r-- 1 zz374 rosenclassGrp  66K Apr 12 16:15 jaccard_pcoa_results.qza
-rw-r--r-- 1 zz374 rosenclassGrp  52K Apr 12 16:15 observed_otus_vector.qza
-rw-r--r-- 1 zz374 rosenclassGrp  77K Apr 12 16:15 rarefied_table.qza
-rw-r--r-- 1 zz374 rosenclassGrp  52K Apr 12 16:15 shannon_vector.qza
-rw-r--r-- 1 zz374 rosenclassGrp 355K Apr 12 16:15 unweighted-unifrac-body-site-significance.qzv
-rw-r--r-- 1 zz374 rosenclassGrp  58K Apr 12 16:15 unweighted_unifrac_distance_matrix.qza
-rw-r--r-- 1 zz374 rosenclassGrp 777K Apr 12 16:15 unweighted-unifrac-emperor-DaysSinceExperimentStart.qzv
-rw-r--r-- 1 zz374 rosenclassGrp 777K Apr 12 16:15 unweighted_unifrac_emperor.qzv
-rw-r--r-- 1 zz374 rosenclassGrp  66K Apr 12 16:15 unweighted_unifrac_pcoa_results.qza
-rw-r--r-- 1 zz374 rosenclassGrp 289K Apr 12 16:15 unweighted-unifrac-subject-group-significance.qzv
-rw-r--r-- 1 zz374 rosenclassGrp  58K Apr 12 16:15 weighted_unifrac_distance_matrix.qza
-rw-r--r-- 1 zz374 rosenclassGrp 777K Apr 12 16:15 weighted_unifrac_emperor.qzv
-rw-r--r-- 1 zz374 rosenclassGrp  63K Apr 12 16:15 weighted_unifrac_pcoa_results.qza
```

# Acknowledgements

* This tutorial instruction is adapted from a previous version made by [Gregory Ditzler](https://github.com/gditzler/bio-course-materials/tree/master/proteus-demo). 
 
# Supplementary commands:
1. For taxanomic analysis, download Greengenes file from 2018.8 so that the file can be used by Qiime2-2018 installed on Proteus.
```
wget \
  -O "gg-13-8-99-515-806-nb-classifier.qza" \
  "https://data.qiime2.org/2018.8/common/gg-13-8-99-515-806-nb-classifier.qza"
```
