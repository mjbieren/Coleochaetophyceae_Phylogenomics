#!/bin/bash

#Follow Armins guide on setting up orthofinder!
# https://github.com/dadrasarmin/orthofinder_hpc_gwdg

SPECIES_DIR= #change this, combination of all the positive sets from GPDS.sh + Outgroup, recommend to create a new one
TREE_FILE~/09_Orthofinder/Coleo_Orthofinder_GuideTree.txt #example Complete_Klebsotree.txt #change this
OUTPUT_DIR= #change this Be sure not to create the directory orthofinder does this for you
OUTPUT_SUFFIX=ort_coleo #change this to what you want
ORTHOFINDER_PATH=~/orthofinder.py #Path to orthofinder.py

#Just to make sure the directory doesn't already exist, because Orthofinder can not handle that...
#Before you run this script, be sure to do "ulimit 1000000" since you otherwise will get an error, due to the file limitation (too much files open).



python $ORTHOFINDER_PATH -f $SPECIES_DIR -S diamond -M msa -A mafft -T fasttree -t 100 -a 6 -y -n $OUTPUT_SUFFIX -o $OUTPUT_DIR &> orthofinder_${OUTPUT_SUFFIX}.log
