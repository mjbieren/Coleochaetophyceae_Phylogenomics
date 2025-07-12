# 11. MAFFT and IQ-TREE All Fasta Files (MIAF)

In this step, we prepare multiple sequence alignments and phylogenetic trees for all orthogroup FASTA files using **[MIAF](https://github.com/mjbieren/MIAF/)** — a job manager specifically designed to run **MAFFT** and **IQ-TREE** on batches of FASTA files.

MIAF performs the following:
- Iterates through all `.fasta` files in a specified directory
- Runs **MAFFT** to align the sequences
- Runs **IQ-TREE** to infer gene trees
- Collects and organizes relevant output files into a structured output folder

### HPC and SLURM Integration
MIAF is optimized for use on High-Performance Computing (HPC) systems using SLURM. It includes:
- Job throttling to prevent exceeding job submission limits
- Automatic self-restarting if the job limit is reached

---

### Usage Examples

You can find example usage scripts in this repository:

- [11A_MIAF_INGROUP_SET.sh](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/blob/main/Scripts/11_MIAF/11A_MIAF_INGROUP_SET.sh)  
- [11B_MIAF_OUTGROUP_SET.sh](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/blob/main/Scripts/11_MIAF/11B_MIAF_OUTGROUP_SET.sh)

These show how to run MIAF for both ingroup and outgroup datasets.

---

For full documentation and installation instructions, see the [MIAF GitHub repository](https://github.com/mjbieren/MIAF/).
