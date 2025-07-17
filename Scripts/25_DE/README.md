
# 25. Differential Expression Interpretation for Orthogroups

In this step, we assess gene expression variation across the dataset to identify potential differential expression patterns. While results should be interpreted cautiously, they may highlight genes that are more transcriptionally active in certain **Coleochaetophyceae** orders.

---

## 🧬 Kallisto – Transcript Quantification

We begin with **Kallisto** quantification using the same **Trinity Singularity image** employed during *de novo* transcriptome assembly (see Step 2).

➡️ Example script:  
[25A_TranscriptQuantitification_Trinity_Combined_ALL.sh](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/blob/main/Scripts/25_DE/25A_TranscriptQuantitification_Trinity_Combined_ALL.sh)

This step produces TPM abundance estimates for each transcript/sample.

---

## 📊 GTVO – Gene TPM Value Organizer

Once the TPM files are generated, we use [GTVO](https://github.com/mjbieren/GTVO/) to summarize TPM values across orthogroups (HOGs). This tool integrates expression, orthology, and renaming information.

### 🔧 GTVO Required Arguments

| Argument | Description |
|----------|-------------|
| `-f`     | Path to **COGS PPP output** (FASTA files) from Step 16 |
| `-p`     | Path to **COGS FilterPPP output** from Step 17 |
| `-c`     | Folder with `.headers_map.out` files (renamed protein headers used in OrthoFinder input) |
| `-t`     | Folder containing TPM tables (1 per species, from Kallisto) |
| `-r`     | Output folder for GTVO result tables |
| `-g`     | Taxonomic group file (controls header order; found in this repository) |
| `-o`     | OrthoFinder output folder (must contain `N0.tsv`; from Step 10 input) |
| `-x`     | Prefix for output files |

### ▶️ Example Command

```
GTVO_Static_Debian.out -f <PPP_OUTPUT> -p <FPPP_OUTPUT> -c <PROTEIN_CHANGED_NAMES_FOLDER> -t <TPM_VALUES> -g <TAXONOMICGROUP_FILE> -o <ORTHOFINDER_OUTPUT_FOLDER> -x <PREFIX_OUTPUT> -r <OUTPUT_FOLDER>
```

➡️ Example script: 
[25B_GTVO_Example.sh](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/blob/main/Scripts/25_DE/25B_GTVO_Example.sh)


This will generate expression summary tables showing TPM values across species for each orthogroup. These tables can be analyzed for patterns in gene activity among Coleochaetophyceae orders.

---

## 📁 Output

GTVO creates TPM tables with the following structure:

```
Orthogroup     Species_1     Species_2     ...     Species_N
HOG0001          1.32          0.00                 3.45
HOG0002          N/A           1.22                 0.00
...
```

These outputs are helpful for downstream differential expression exploration.

---

## 👩‍🔬 Contact

**Maaike Jacobine Bierenbroodspot**  
📧 maaikejacobine.bierenbroodspot@uni-goettingen.de
