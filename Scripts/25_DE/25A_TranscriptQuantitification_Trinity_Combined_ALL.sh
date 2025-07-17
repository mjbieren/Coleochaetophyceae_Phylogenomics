#!/bin/bash
#If you use a singularity command be sure to change all your full paths to mnt as a start path since you have to mount your directory. Change the path accordingly. In this case /data/ is turned into /mnt/
SINGULARITY_HOME_PATH=${PWD}
SAMPLE_FILES=[PATH]/Samples_file_baltica.txt #replace the first folder with "mounted"
TRANSCRIPT_FILE=[PATH]/TRINITY_BALT.Trinity.fasta #replace the first folder with "mounted"
GENE_TRANS_MAP=[PATH]TRINITY_BALT.Trinity.fasta.gene_trans_map #replace the first folder with "mounted"
EST_METHOD=kallisto #Alignment based: RSEM, Alignment_Free:kallisto|salmon
THREAD_COUNT=50
OUT=/home/02_Quantification/
SINGULARITY_TRINITY_IMAGE=[PATH]/Singularity_Images/Trinity/trinityrnaseq.v2.15.1.simg #You've to download it from the Trinity website. get latest from: https://data.broadinstitute.org/Trinity/TRINITY_SINGULARITY/

#Testing
#singularity exec --bind /data:/mnt $SINGULARITY_TRINITY_IMAGE ls /mnt

#To remove the local error for perl
export LC_ALL=C

singularity exec --bind /data:/mounted $SINGULARITY_TRINITY_IMAGE /usr/local/bin/util/align_and_estimate_abundance.pl --transcripts $TRANSCRIPT_FILE --gene_trans_map $GENE_TRANS_MAP --seqType fq --samples_file $SAMPLE_FILES --est_method $EST_METHOD --thread_count $THREAD_COUNT --output_dir $OUT --prep_reference --trinity_mode
