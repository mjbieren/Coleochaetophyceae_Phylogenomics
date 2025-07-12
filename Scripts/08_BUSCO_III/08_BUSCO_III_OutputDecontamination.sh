#!/bin/bash

WORKDIR~/Coleocheatophyceae/Samples_AfterDecontamination/
OUTPUT_DIR=~/Coleocheatophyceae/Busco_III/

cd $WORKDIR

FILES=`find . -maxdepth 1 -type f -name '*.fa' -exec basename -a {} + | sed 's/.fa//g'`

for f in $FILES
do
(

busco -m proteins -i ${f}.fa -o ${OUTPUT_DIR}${f} -f -l eukaryota_odb10

)
done