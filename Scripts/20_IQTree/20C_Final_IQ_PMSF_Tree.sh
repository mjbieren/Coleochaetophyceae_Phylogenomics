#!/bin/bash

IQ_TREEPATH=iqtree3 #iqtree2 full path
THREADS=100 #Use less if less is available
MEMORY=1500G #Use less if less is available
FILE_INPUT= #Alignment file output form step 19
MSUB=nuclear #What type of AA models, can be nuclear, mitochondrial, chloroplast or viral.
BRANCH_TEST_REPLICATES=1000
AUTOMATIC_MODEL_SELECTION=LG+C60+F+G #Fixed
OUTPUT_PREFIX= #Change this
GUIDE_TREE= #Output from script 20B. Ends with .treefile (Final_IQ_Tree_) Run that one first!

$IQ_TREEPATH -nt $THREADS -m $AUTOMATIC_MODEL_SELECTION -msub $MSUB -s $FILE_INPUT -bb $BRANCH_TEST_REPLICATES -alrt $BRANCH_TEST_REPLICATES -pre $OUTPUT_PREFIX -ft $GUIDE_TREE -mem $MEMORY