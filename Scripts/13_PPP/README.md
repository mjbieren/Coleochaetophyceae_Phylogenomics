# 13. PhyloPyPruner

This step is essential to remove **paralogs** from the orthogroup alignments, ensuring that each orthogroup contains only **one representative sequence per species**. This pruning is critical for building reliable phylogenomic trees.

Throughout the Coleochaetophyceae phylogenomics project, we tested different settings depending on whether we prioritized resolution in the ingroup or the outgroup clades.

## Configurations Used

1. **Ingroup-focused pruning**  
   [`13A_PhyloPruner_I_Conda_Ingroup`](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/blob/main/Scripts/13_PPP/13A_PhyloPruner_I_Conda_Ingroup.sh)  
   Applied to the Ingroup set, where filtering happens **after** PhyloPyPruner. This setup yields strong branch support within the ingroup (Coleochaetophyceae). Settings used in PPP:
   ```
   --mask pdist --prune MI --min-taxa 3 --trim-lb 5 --min-support 0.75 --threads 50 --trim-divergent 1.25 --jackknife --no-plot --overwrite
   ```
3. **Outgroup-focused pruning**  
   [`13B_PhyloPruner_I_Conda_Outgroup.sh`](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/blob/main/Scripts/13_PPP/13B_PhyloPruner_I_Conda_Outgroup.sh)  
   The set is focused on the outgroup set. This configuration favors **high aLRT support for outgroups**. Settings used in PPP:
   ```
   --mask pdist --prune MI --min-taxa 10 --trim-lb 5 --min-support 0.75 --min-gene-occupancy 0.1 --min-otu-occupancy 0.1 --threads 50 --trim-divergent 1.25 --min-pdist 1e-8 --jackknife --no-plot  --overwrite
   ```



> Note: All runs were performed within a Conda environment inside a `tmux` session

---

## About PhyloPyPruner

[**PhyloPyPruner**](https://github.com/fethalen/phylopypruner) is a Python tool developed by Dr. Felicia Sandberg for orthology inference based on **phylogenetic tree topology**. It implements a **species-overlap method** to retain single-copy orthologs across a set of species.

- Written in Python
- Easily installed via Conda or pip
- Ideal for phylogenomics pipelines requiring paralog pruning prior to tree inference

For installation instructions and documentation, please refer to the official GitHub repository:  
[https://github.com/fethalen/phylopypruner](https://github.com/fethalen/phylopypruner)
