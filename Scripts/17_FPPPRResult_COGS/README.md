# Step 17: Filter Combined Set with FilterPPPResult

After paralog pruning, we further refined the dataset by filtering orthogroups based on taxonomic representation using [FilterPPPResult](https://github.com/mjbieren/FilterPPPResult/).

This tool evaluates each aligned orthogroup from the PhyloPyPruner output and retains only those that include sequences from a minimum number of distinct taxonomic groups. It also offers options to simplify sequence headers and remove alignment gaps for cleaner downstream processing.

For this project, we applied a threshold of at least **10 out of 28** taxonomic groups.

Additionally, we used the `-a` and `-h` parameters to:
- `-a`: remove alignment gaps (`-`) from the sequences.
- `-h`: remove gene IDs from the FASTA headers, since all entries now represent single-copy orthologs.

📄 The same taxonomic group file was used for filtering the combined set
See:  
[`Coleocheatephyceae_TaxonomicGroupFile_FilterPPP_Set.txt`](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/blob/main/Scripts/14_FPPPResult/Coleocheatephyceae_TaxonomicGroupFile_FilterPPP_Set.txt)

📜 Example script:  
[`17_FilterPPP_Result_AndRemoveHeadersNumbers_COGS.sh`](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/blob/main/Scripts/17_FPPPRResult_COGS/17_FilterPPP_Result_AndRemoveHeadersNumbers_COGS.sh)
