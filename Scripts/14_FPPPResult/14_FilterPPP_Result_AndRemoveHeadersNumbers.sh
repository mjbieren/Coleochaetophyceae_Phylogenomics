#!/bin/bash

PROGRAMPATH=~/Programs/FilterPPPResult/FilterPPPResult_Debian.out #FilterPPPResult_Debian.out Change the path
INPUT= #<OutputFolderScript13A/phylopypruner_output/output_alignments/ #phylopypruner_output/output_alignments/ #Change This

OUTPUT= #Change This Output Path. Be sure to make it different than Script 14B
TAXONOMIC_GROUPFILE=~/TaxonomicGroup/Coleocheatephyceae_TaxonomicGroupFile_FilterPPP_Set.txt #Taxonomic Group file see (See /10_OrthogroupSequenceGrabber_OSG/TaxonomicGroupFiles/ for examples)
SUMMARY_FILE= #Output folder where the summary file ends up. Don't make it the same as the Output folder, since it's hard to find it back otherwise due to the file size.
NUMBER_OF_FILTER_GROUPS=10 #Change This. Threshold of for the amount of taxonomic groups

#Filter PPP result based on NUMBER_OF_FILTER_GROUPS
#with gene ids
#$PROGRAMPATH -f $INPUT -t $TAXONOMIC_GROUPFILE -r $OUTPUT -n $NUMBER_OF_FILTER_GROUPS -s $SUMMARY_FILE

#Without Gene IDs or alignments
$PROGRAMPATH -f $INPUT -t $TAXONOMIC_GROUPFILE -r $OUTPUT -n $NUMBER_OF_FILTER_GROUPS -s $SUMMARY_FILE -a -h

