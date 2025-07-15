#!/bin/bash

#To create a working prequal conda environment do the following:
#conda create -n phyx -c conda-forge -c bioconda phyx
#

source activate phyx

INPUT_FOLDER= #InputFolder with all the files from output script 18 #Change This
OUTPUT_File= #Output file path+name
FILE_EXTENSION=fas #can also be .fa, it's up to you

#Folder
cd $INPUT_FOLDER
pxcat -s *.${FILE_EXTENSION} -p ${OUTPUT_File}.output_partition_file -o ${OUTPUT_File}.${FILE_EXTENSION}

conda deactivate