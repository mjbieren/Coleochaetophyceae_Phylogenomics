# Concatenate Alignments

This step concatenates multiple alignments into a single large alignment file using **phyx**, a set of phylogenetic tools for Unix.

To run this, edit and execute the script [ConcatAlignments_FromAnyFolder_Phyx.sh](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/blob/main/Scripts/17_ConcatenateSequences/ConcatAlignments_FromAnyFolder_Phyx.sh). You can run it either within a conda environment (if phyx is not installed locally) or directly on your system.

To create a conda environment with phyx use:

```
conda create -n phyx -c conda-forge -c bioconda phyx
```


And run with:
```
pxcat -s *.[FILE_EXTENSION] -p [OUTPUT_File].output_partition_file -o [OUTPUT_File].[FILE_EXTENSION]
```
See [19_Concatenate_phyx.sh]() for an example script.
