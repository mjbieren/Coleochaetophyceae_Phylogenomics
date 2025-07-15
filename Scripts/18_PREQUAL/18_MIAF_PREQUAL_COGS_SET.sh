#!/bin/bash

#To create a working prequal conda environment do the following:
#conda create -n prequal -c bioconda prequal clipkit -c conda-forge tmux 
#

source activate prequal

#Program format can be any order after program path

#MIAF_PATH.out -i <FastaFileFolder> -r <OutputFolder -m <Path to MAFFT> -q <IQTree Path>. -c <Job limit> -q <Thread per Job> -b <Script Path aka this file> -t <Time limit in seconds> -s <System Type>

#-i <Fasta File Directory>\t\t Set the Path to the directory containing your Fasta files: REQUIRED
#-r <OutputFolderPath>\t\t Set the Output Folder Path where your scripts are moved into: REQUIRED
#-m <Mafft Path>\t\t Path to Mafft. If installed you can also just use 'mafft': REQUIRED
#-q <IQTree Path> \t\t Path to IQTree. If Installed you can also use for e.g. iqtree: REQUIRED REQUIRED
#-c <CPU Limit> \t\t How much threads/jobs can be run simulteanously: NOT REQUIRED
#-x <IQThread Limit> \t\t How much threads you want IQTree to run on. Keep in mind that the IQThread limit value x the CPU value can not exceed the total amount of threads, unless you want to slow down the machine tremendously 
#-b <Path to Script>\t\t Path to the original script its' running it. Only needed if you have a time limit: NOT REQUIRED
#-t <Time limit in seconds> \t\t Time limit of the current job.: NOT REQUIRED %s
#-s <System Type> \t\t  Either -s s (for Slurm) or -s n (for running it locally). Default is normally: NOT REQUIRED
#-p  By setting this feature, prequal/qinsi/clipkit will be run (prequal and clipkit has to be installed on the system! Leaving this one out will run mafft/iqtree: NOT REQUIRED

#Program Path
MIAF_PATH=~/Programs/MIAF/MIAF_Debian_Static.out #Don't Touch
#OSG output folder aka the fasta files
INPUT= #Change this (Output of script 17)


#Output Folder
OUTPUT= #Change this

#MAFFT
MAFFT=~/Programs/mafft-linux64/mafft.bat

SYTEMTYPE=n #Don't touch on gandalf!!!

#JOB Limit
JOB_LIMIT=50 #will run 50 jobs at the same time

#threads used in MAFFT and other tools
THREAD_PER_JOB=2 #meaning 50x2 threads are running (aka 100, we have 256 on Gandalf be AWARE!!!)


${MIAF_PATH} -i ${INPUT} -r ${OUTPUT} -m ${MAFFT} -c ${JOB_LIMIT} -x ${THREAD_PER_JOB} -s ${SYTEMTYPE} -p

conda deactivate