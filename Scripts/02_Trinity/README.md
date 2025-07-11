# Trinity Assembly

This repository contains resources for the **second step** in the transcriptome assembly pipeline, which uses [Trinity](https://github.com/trinityrnaseq/trinityrnaseq) for de novo RNA-Seq assembly.

## Usage

### 1. On a SLURM HPC System

For cluster environments that use SLURM, use the following script:

👉 [`02_Trinity_HPC_Singularity_Pair.sh`](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/blob/main/Scripts/02_Trinity/02_Trinity_HPC_Singularity_Pair.sh)

Due to frequent updates in SLURM configurations and dependency issues with Conda environments, this step is run using a Singularity container.

- **Singularity Image**:  
  The pre-built image for Trinity is available here:  
  [TRINITY_SINGULARITY_IMAGE](https://data.broadinstitute.org/Trinity/TRINITY_SINGULARITY/)

### 2. On a Local Machine

If you prefer to run Trinity locally using Singularity, refer to:

👉 [`02_Trinity_SingleMachine.sh`](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/blob/main/Scripts/02_Trinity/02_Trinity_SingleMachine.sh)

Be sure to modify the script to match your local setup (e.g., paths, input files, and number of threads).

## Additional Resources

- **Trinity GitHub Repository**: [trinityrnaseq/trinityrnaseq](https://github.com/trinityrnaseq/trinityrnaseq)
- **Trinity Wiki (Highly Recommended)**: [Trinity Wiki](https://github.com/trinityrnaseq/trinityrnaseq/wiki)

---

