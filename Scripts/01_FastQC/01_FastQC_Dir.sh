#!/bin/bash

DIR= #Input directory of the samples. 

OUTDIR= #Output Directory of the FASTQC

mkdir -p "$OUTDIR" || exit -1

FILES=`find ${DIR} -type f -name '*.gz'`

for f in ${FILES}
do
{
	echo "Working on file ${f}"
	fastqc ${f} -o ${OUTDIR}
}
done



