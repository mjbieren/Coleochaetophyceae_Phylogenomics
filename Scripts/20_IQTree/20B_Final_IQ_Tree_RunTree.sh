#!/bin/bash

IQ_TREEPATH=iqtree3 #iqtree2 full path
THREADS=100 #Use less if less is available
MEMORY=1000G #Use less if less is available
FILE_INPUT= #Alignment file output form step 19
MSUB=nuclear #What type of AA models, can be nuclear, mitochondrial, chloroplast or viral.
BRANCH_TEST_REPLICATES=1000
AUTOMATIC_MODEL_SELECTION=LG+C60 #Based on the output of script 20A, but I expect it to be LG+C60
OUTPUT_PREFIX= #Change this to your own.

$IQ_TREEPATH -nt $THREADS -m $AUTOMATIC_MODEL_SELECTION -msub $MSUB -s $FILE_INPUT -bb $BRANCH_TEST_REPLICATES -alrt $BRANCH_TEST_REPLICATES -pre $OUTPUT_PREFIX -mem $MEMORY