#!/bin/bash

IQ_TREEPATH=iqtree3
THREADS=75
FILE_INPUT=Coleo_Tax10_COGS_Concat.fas #Alignment file output form step 18
MSUB=nuclear #What type of AA models, can be nuclear, mitochondrial, chloroplast or viral.
BRANCH_TEST_REPLICATES=1000
OUTPUT_PREFIX= #Change this to your own
MEMORY=1000G

#Only Run ModelFinder
$IQ_TREEPATH -nt $THREADS -m MF -madd LG+C60 -msub $MSUB -s $FILE_INPUT -pre $OUTPUT_PREFIX -mem $MEMORY

#Run with the Tree
#$IQ_TREEPATH -nt $THREADS -m MFP -madd LG+C60 -msub $MSUB -s $FILE_INPUT -bb $BRANCH_TEST_REPLICATES -alrt $BRANCH_TEST_REPLICATES -pre $OUTPUT_PREFIX -mem $MEMORY 