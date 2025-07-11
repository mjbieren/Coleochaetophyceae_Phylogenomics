#!/bin/bash
#SBATCH -p medium
#SBATCH -t 48:00:00
#SBATCH -o %J_ColeoTrinity.out
#SBATCH -c 24
#SBATCH -C scratch
#SBATCH --exclusive
#SBATCH --mem 300G
#SBATCH --mail-type=BEGIN,END
#SBATCH --mail-user=<YOUREMAILHERE@Domain.net>

SINGULARITY_HOME_PATH=${PWD} #Generally don't change or know what you're doing ;)
CPU=24 #change
RAM=300G #Change
STRAIN=${PWD##**/} #Name of the output file, generally I use the strain name but you can also do whatever you want here. Just that the files will be named like that :) I've my raw samples ordered as: ~/STRAINNAME/RawData/x_1.fq.gz | x_2.fq.gz. The output file will be named in this case STRAINNAME.Trinity.fasta and STRAINNAME.Trinity.gene_maps
TRINITY_OUTPUT=Trinity_Output #Don't touch (This script auto deletes the trinity output file, as this creates easily a couple 100g in data).
IN1=/home/RawData/SAMPLE1_1.fq.gz #FullPath_x1_1.fg.qz,FullPath_x2_1fq.gz //Change Pair Left
IN2=/home/RawData/SAMPLE1_2.fq.gz #x1_2.fg.qz,x2_2fq.gz //Change Pair Right

SINGULARITY_TRINITY_IMAGE=~/Singularity_Objects/Trinity/trinityrnaseq.v2.15.1.simg #Change this to your trinity singularity (Downlaod at: https://data.broadinstitute.org/Trinity/TRINITY_SINGULARITY/)

module load singularity/3.8.5 #Change this accordingingly if that version is not correct

#Novogene adapter Pair
singularity exec --home ${SINGULARITY_HOME_PATH}:/home -e ${SINGULARITY_TRINITY_IMAGE} Trinity --seqType fq --left ${IN1} --right ${IN2} --output /home/${TRINITY_OUTPUT} --CPU ${CPU} --trimmomatic --full_cleanup --max_memory ${RAM} --quality_trimming_params "ILLUMINACLIP:/mnt/uni08/applbioinfdevries/MAAIKE/Adapters/novogene_adapter_sequences.fa:2:30:10:2:keepBothReads LEADING:3 TRAILING:3 MINLEN:36"


#Rename the last output files :)
mv ${SINGULARITY_HOME_PATH}/Trinity_Output.Trinity.fasta ${SINGULARITY_HOME_PATH}/${STRAIN}.Trinity.fasta
mv ${SINGULARITY_HOME_PATH}/Trinity_Output.Trinity.fasta.gene_trans_map ${SINGULARITY_HOME_PATH}/${STRAIN}.Trinity.gene_maps

module purge

#Remove the Trinity output folder in case it isn't deleted (sometimes happens.) but ignore if it already happens.
rm -r ${SINGULARITY_HOME_PATH}/${TRINITY_OUTPUT} || true
