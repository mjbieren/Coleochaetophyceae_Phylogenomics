# BUSCO I

The fourth step involves running BUSCO to assess the completeness of the alignments. This provides a reliable indication of whether the dataset is suitable for downstream analyses.

In this project, BUSCO was available as a pre-installed module on our High Performance Computing (HPC) system. Alternatively, BUSCO can be installed and run via a Conda environment:

```
conda create -n busco -c conda-forge -c bioconda busco
```
Once installed, you can configure and execute the analysis by editing and running the provided [04_Busco_I_Conda.sh](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/blob/main/Scripts/04_BUSCO_I/Busco_I.sh) script.

For more detailed information about BUSCO, please visit their official website: BUSCO
