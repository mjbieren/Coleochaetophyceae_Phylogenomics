#!/bin/bash

source activate Busco
CURRENTDIR=`pwd`
#Input
IN=${PWD##**/}_genes_supertranscript.fasta.transdecoder.pep
#Mode
#MODE=genome
MODE=proteins
#MODE=transcriptome
#Output folder
OUT=Busco_II_Out/

#Create output folder so that the work dir isn't overcrowded. the "exit -1" is to make sure that the script doesn't continue if the directory creation fails. The -p options is to make sure that no error occurs when a directory already exist.
mkdir -p "${CURRENTDIR}/$OUT" || exit -1


#Busco Run
#Auto lineage with only eukaryotic
#busco -m $MODE -i $IN -o $OUT -f --auto-lineage-euk

#Busco with specified lineage selection (eukaryota_odb10)
busco -m $MODE -i $IN -o $OUT -f -l eukaryota_odb10
#busco -m transcriptome -i Trinity_Out.Trinity.fasta -o Busco_Out -f -l eukaryota_odb10

conda deactivate
