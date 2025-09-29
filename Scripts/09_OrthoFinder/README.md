# Step 9: OrthoFinder – Orthogroup Inference

This step involves running [OrthoFinder](https://github.com/davidemms/OrthoFinder) to infer **orthogroups** across the complete dataset.

## 🧬 Input Requirements

Before running OrthoFinder, make sure to:

- Include **all high-quality, decontaminated samples**.
- Add a sufficient number of **outgroup species** to improve phylogenetic resolution.
- **Reformat FASTA headers** using the script made by Dr. Iker Irrisari [simplify_headers_for_blastdb.py](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/blob/main/Scripts/07_Decontamination/simplify_headers_for_blastdb.py) and run it with the command below, to ensure compatibility with OrthoFinder, BLAST and further downstream analysis:

```
python simplify_headers_for_blastdb.py [inputFile] [RenameHeaders] >> [FileOutput]
```

The version I ran was based on the GitHub release, but you can also install Orthofinder with conda using:

```
conda install orthofinder -c bioconda
```

To guide the inference process and improve the accuracy of the orthology assignment, the guide tree [Coleo_Orthofinder_GuideTree.txt](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/blob/main/Scripts/09_OrthoFinder/Coleo_Orthofinder_GuideTree.txt) was used.


>[!NOTE]
>From OrthoFinder v3.1.0, N0.tsv is removed from /Phylogenetic_Hierarchical_Orthogroups. Instead, Orthogroups/Orthogroups.tsv contains the orthogroups from N0.tsv.


See [09_Orthofinder.sh](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/blob/main/Scripts/09_OrthoFinder/09_Orthofinder.sh) for an example script for this step.
