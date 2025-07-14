# PhyloPyPruner on the Combined Set

After merging the two orthogroup sets, we obtained a unified dataset containing non-redundant orthogroups. However, this combined set still includes potential paralogs that need to be pruned before further analysis.

To address this, we rerun [PhyloPyPruner](https://github.com/fethalen/phylopypruner) — a tool developed by Dr. Felicia Sandberg — to perform paralog pruning and refine the orthogroup alignments.

## Settings Used
We used the following recommended parameters for optimal filtering and pruning:

```
--mask pdist --prune MI --min-taxa 3 --trim-lb 5 --min-support 0.75 --threads 50 --trim-divergent 1.25 --jackknife --no-plot --overwrite
```


These settings ensure:
- Distance-based masking (`--mask pdist`)
- Minimum inclusion pruning (`--prune MI`)
- A minimum of 3 taxa per orthogroup
- Removal of low-branch support tips (`--trim-lb`)
- Minimum bootstrap support of 0.75
- Efficient multithreading with 50 threads
- Trimming of highly divergent sequences
- Use of jackknife resampling
- No plotting for streamlined output
- Overwriting existing files if present

## Example Script

You can find an example implementation of this step in the following script:

📄 [16_PhyloPruner_I_Conda_COGS.sh](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/blob/main/Scripts/16_PPP_COGS/16_PhyloPruner_I_Conda_COGS.sh)
