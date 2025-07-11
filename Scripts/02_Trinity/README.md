# Trinity
This is the second step within the pipeline. 
Generally, you just have to edit [02_Trinity_HPC_Singularity_Pair.sh](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/blob/main/Scripts/02_Trinity/02_Trinity_HPC_Singularity_Pair.sh) if you run Trinity in a slurm system. <br/>
As updates happen on the slurm system and the conda environment for the Trinity setup is a bit complicated as package dependage is sometimes an issue, I ran this step with a singularity file. That can be found here: [TRINITY_SINGULARITY_IMAGE](https://data.broadinstitute.org/Trinity/TRINITY_SINGULARITY/)

Alternatively you can run it locally with singularity by adjusting the [02_Trinity_SingleMachine.sh](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/blob/main/Scripts/02_Trinity/02_Trinity_SingleMachine.sh)

For more information, go to the [Trinity Github](https://github.com/trinityrnaseq/trinityrnaseq) <br/>
I highly recommend reading their [Wiki site](https://github.com/trinityrnaseq/trinityrnaseq/wiki), which explains everything pretty well.
