#!/bin/bash

source activate rnaseq

CURRENTDIR=`pwd`
#Input
IN=${PWD##**/}_genes_supertranscript.fasta
#Mode
#MODE=genome
#MODE=proteins
MODE=transcriptome
#Output folder
OUT=${CURRENTDIR}/transdecoder_dir/

#Create output folder so that the work dir isn't overcrowded. the "exit -1" is to make sure that the script doesn't continue if the directory creation fails. The -p options is to make sure that no error occurs when a directory already exist.
mkdir -p "${$OUT}" || exit -1

TransDecoder.LongOrfs -t $IN --output_dir $OUT || exit -1  

TransDecoder.Predict -t $IN --output_dir $OUT --single_best_only || exit -1 #--single_best_only
