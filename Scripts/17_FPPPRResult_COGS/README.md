# Step 17: Filter Combined Set with FilterPPPResult

After paralog pruning, we further refined the dataset by filtering orthogroups based on taxonomic representation using [FilterPPPResult](https://github.com/mjbieren/FilterPPPResult/).

This tool evaluates each aligned orthogroup from the PhyloPyPruner output and retains only those that include sequences from a minimum number of distinct taxonomic groups. It also offers options to simplify sequence headers and remove alignment gaps for cleaner downstream processing.

For this project, we applied a threshold of at least **10 out of 28** taxonomic groups.

📄 The same taxonomic group file was used for
See:  
[`Coleocheatephyceae_TaxonomicGroupFile_FilterPPP_Set.txt`](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/blob/main/Scripts/14_FPPPResult/Coleocheatephyceae_TaxonomicGroupFile_FilterPPP_Set.txt)

As an example see:
[17_FilterPPP_Result_AndRemoveHeadersNumbers_COGS](
