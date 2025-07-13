#!/bin/bash

PROGRAMPATH=~/Programs/COGS/COGS_Static_Debian.out #FilterPPPResult_Debian.out Change the path
FPPP_INGROUP_OUTPUT= #Output of script 14A
PPP_INGROUP_INPUT= #Input for script 13A
FPPP_OUTGROUP_OUTPUT= #Output of script 14B
PPP_OUTGROUP_INPUT= #Input for script 13B

#Filter PPP result based on NUMBER_OF_FILTER_GROUPS
#with gene ids
#$PROGRAMPATH -f $INPUT -t $TAXONOMIC_GROUPFILE -r $OUTPUT -n $NUMBER_OF_FILTER_GROUPS -s $SUMMARY_FILE

#-f <FastaFilesBase>			Set the Path to the directory containing your fasta files: REQUIRED
#-s <FastaFileFirstSet>			Set the Path to the first orthogroup set in fasta file formats: REQUIRED
#-t <FastaFileSecondSet>		Set the Path to the second orthogroup set in fasta file formats: REQUIRED
#-o <OrthoGroupFilesPath>		Set the Path to the directory containing the Orthogroups in TSV format: REQUIRED
#-r <OutputDirPath>				Set the Path to directory where the output files have to be written to: REQUIRED
#-p								Changes all fasta headers into the format needed for PhyloPyPruner: NOT REQUIRED. Not setting it will result in the same fasta headers as the fasta files uses.
#-x <PPPInputDirSet1>			Use Input directory of Set one for PhyloPyPruner instead of the base file.
#-y <PPPInputDirSet2>			Use Input directory of Set two for PhyloPyPruner instead of the base file.

$PROGRAMPATH -s $FPPP_INGROUP_OUTPUT -x $PPP_INGROUP_INPUT -t $FPPP_OUTGROUP_OUTPUT -y $PPP_OUTGROUP_INPUT

