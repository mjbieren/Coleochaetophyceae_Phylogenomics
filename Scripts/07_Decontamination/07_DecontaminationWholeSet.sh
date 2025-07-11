#!/bin/bash

WORKDIR= #Where all transdecoder outputs are :)
DB=~/Database/Decontamination_Database_Base_Coleo/Decontamination_Coleo_DB.db #change
HEADERFILE=~/Database/Decontamination_Database_Base_Coleo/Headerfile_coleo.txt #Change
COPYDIR= #Directory where your positive set goes (They will get renamed without the _Positive suffix)
PROGRAM_PATH=~/Programs/GetPositiveDataSet/GPDS_Debian_Static.out #change
PATH_TO_SIMPLIFY_HEADER_SCRIPT=~/Programs/Simplify_Headers/simplify_headers_for_blastdb.py #Change
MMSEQSPATH=~/Programs/mmseqs/mmseqs/bin/mmseqs #Change

cd ${WORKDIR}

FILES=`find . -maxdepth 1 -type f -name '*_genes_supertranscript.fasta.transdecoder.pep' -exec basename -a {} + | sed 's/_genes_supertranscript.fasta.transdecoder.pep//g'`

for f in ${FILES}
do
(
#Index
${MMSEQSPATH} createdb ${f}_genes_supertranscript.fasta.transdecoder.pep ${f}_DB.db
${MMSEQSPATH} createindex ${f}_DB.db tmp
rm -r ${WORKDIR}tmp

#Decontamination
${MMSEQSPATH} search ${f}_DB.db ${DB} ${f}_vs_Decontamination.mmseqs2_decont tmp_${f} --start-sens 1 --sens-steps 3 -s 7 --alignment-mode 3 --max-seqs 10 --threads 8
# convert output format to BLAST+ TAB
${MMSEQSPATH} convertalis ${f}_DB.db ${DB} ${f}_vs_Decontamination.mmseqs2_decont ${f}_vs_Decontamination.mmseqs2_decont.outfmt6 --format-mode 2

#GetPositiveDataset
mkdir ${f}_GPDS
${PROGRAM_PATH} -i ${HEADERFILE} -f ${f}_genes_supertranscript.fasta.transdecoder.pep -b ${f}_vs_Decontamination.mmseqs2_decont.outfmt6 -c 11 -s ${f} -r ${WORKDIR}${f}_GPDS/

#Copying Positive dataset and simplifying the headers (needed later :) )
python ${PATH_TO_SIMPLIFY_HEADER_SCRIPT} ${WORKINGDIR}${f}_GPDS/${f}_Coleochaete.fa ${f}>>${COPYDIR}${f}.fa

)
done
