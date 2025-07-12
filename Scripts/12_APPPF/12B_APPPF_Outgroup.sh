#!/bin/bash

APPPF_PATH=~/Programs/APPPF/APPPFormat_Debian.out #APPPFormat.out
TREE_FILES= #Path to the treefiles aka output of step 11B.
TREEFORMAT=treefile #Name of the file extension without a .
APPPF_OUTPUT= #Output Folder for the program. Be sure to be make it different than script 12A
TAXANOMIC_GROUP_FILE=~/TaxonomicGroup/Coleocheatephyceae_TaxonomicGroupFile_Ingroup_Set.txt #Path to your taxanomic group file. Doesn't matter which of the 3 you pick :)

#Program format can be any order after program path
#[Program_Path] -i [PathToTrees] -t [FileExtensionOfTrees] -r [OutputFolderPath] -g [TaxonomicGroupFilePath] -m [MafftFilesPath:NOT REQUIRED]

#-i <PathToTrees> Set the path where the tree files are located. This is in newick format.[REQUIRED]
#-t <TreeFileExtension> Set the extension for the newick trees. For example .treefile.
#-g <TaxonomicGroupFile> Set the Taxonomic Group File, used to find the exact position to replace the _ with @ [REQUIRED]
#-r <OutputFolderPath> Set the Output Folder Path: [REQUIRED]
#-m <PathToMafftFiles> Set the path if you want to move your msa files (.mafft extension) and place them in your output folder. The extension automatically get changed from .mafft to .fa. [NOT REQUIRED]

$APPPF_PATH -i $TREE_FILES -t $TREEFORMAT -r $APPPF_OUTPUT -g $TAXANOMIC_GROUP_FILE -m $TREE_FILES

#copy the .fa files into the output folder, currently APPPF doesn't take .fa (only .mafft)
cd ${TREE_FILES}
cp *.fa ${APPF_OUTPUT}
