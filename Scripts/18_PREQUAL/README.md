# 18_PREQUAL

During this step, we again use [MIAF](https://github.com/mjbieren/MIAF), but with the second method instead.
This tool automates alignment and phylogenetic analysis of multiple FASTA files using **prequal**, **MAFFT (QInSi)**, **ClipKIT**, and optionally **IQ-TREE**.

## Method 2 Workflow

For each FASTA file, MIAF:

1. Runs **prequal** to filter unreliable alignment regions.  
2. Aligns sequences using **MAFFT (QInSi)**.  
3. Trims alignments with **ClipKIT** for improved accuracy.  
4. Optionally runs **IQ-TREE** to infer phylogenetic trees from the trimmed alignments, but computational time increases significantly!.

The output includes processed FASTA files, multiple sequence alignments, and corresponding phylogenetic trees.

## More Information

See [18_MIAF_PREQUAL_COGS_SET.sh](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/blob/main/Scripts/18_PREQUAL/18_MIAF_PREQUAL_COGS_SET.sh) for an example


For detailed usage and examples, visit the [MIAF repository](https://github.com/mjbieren/MIAF).

