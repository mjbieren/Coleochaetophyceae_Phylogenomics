#!/bin/bash

source activate phylopypruner

IN= #Change this. This is the output folder of COGS (Script 15).
OUTPUT= #Change this. this is the output folder for Phylopypruner for COGS

mkdir -p "$OUTPUT" || exit -1
phylopypruner --dir $IN --output $OUTPUT --mask pdist --prune MI --min-taxa 3 --trim-lb 5 --min-support 0.75 --threads 50 --trim-divergent 1.25 --jackknife --no-plot --overwrite

conda deactivate
