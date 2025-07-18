# 20. Phylogenetic Tree Inference with IQ-TREE 3

This step performs **phylogenetic tree inference** using **IQ-TREE 3**, with **ModelFinder**, **C60 models**, and the **PMSF method** for better accuracy on large datasets. 

⚠️ **Important note (as of 4 July 2025):**  
IQ-TREE v3 fixes a known bug with the `-madd` option in its *GitHub version only*. It is **not yet available** in their formal release.  
To use `-madd` properly, you must [build IQ-TREE 3 manually from GitHub](https://github.com/iqtree/iqtree3). You can find a pre-compiled IQTree3 in this directory ([iqtree3](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/blob/main/Scripts/20_IQTree/iqtree3), based on the GitHub repository. But it has only been tested on a Debian system..

---

## 📌 Step-by-Step Instructions

### 1. Run ModelFinder to Determine Best-Fitting Substitution Model

```
iqtree3 -nt <THREADS> -m MF -madd LG+C60 -msub nuclear -s <INPUT_ALIGNMENT.fasta> -pre <OUTPUT_PREFIX> -mem <MEMORY_MB_GB>
```

#### 🔍 Explanation of Parameters:
| Parameter        | Description |
|------------------|-------------|
| `-nt`            | Number of threads to use |
| `-m MF`          | Activates **ModelFinder** to search for the best-fit model |
| `-madd LG+C60`   | Adds **LG+C60** mixture model manually (not included by default) |
| `-msub nuclear`  | Specifies substitution models for **nuclear DNA** |
| `-s`             | Input **aligned** sequence file (FASTA or PHYLIP format) |
| `-pre`           | Prefix for all output files |
| `-mem`           | Maximum memory usage in MB or G |

📌 This step outputs the best model (e.g. `LG+C60+F+G` or `LG+F+I+G4`), which is used for further inference.

Example script: (20A_Final_IQ_Tree_ModelFinder.sh)[https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/blob/main/Scripts/20_IQTree/20A_Final_IQ_Tree_ModelFinder.sh]

Additionally, you can skip `Step 2` by using `-m MFP` instead of `-m MF`, and add ultrafast bootstrap and SH-aLRT tests by `-bb 1000` and `-alrt 1000` respectively.

```
iqtree3 -nt <THREADS> -m MFP -madd LG+C60 -msub nuclear -s <INPUT_ALIGNMENT.fasta> -bb 1000 -alrt 1000 -pre <OUTPUT_PREFIX> -mem <MEMORY_MB_GB>
```

🧠 **MFP = ModelFinder Plus**, which finds the best-fit model and continues with full tree inference.

---

### 2. Infer the Maximum Likelihood Tree (optional if using `-m MFP` directly)

If you did not use `-m MFP` in the previous step, the following step is done with:

```
iqtree3 -nt <THREADS> -m <ModelFinder_BestModelOutput> -msub nuclear -s <INPUT_ALIGNMENT.fasta> -pre <OUTPUT_PREFIX> -mem <MEMORY_MB> -bb 1000 -alrt 1000
```

Example Script: [20B_Final_IQ_Tree_RunTree.sh](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/blob/main/Scripts/20_IQTree/20B_Final_IQ_Tree_RunTree.sh)

---

### 3. Use PMSF Model for Final Tree Inference with Ultrafast Bootstrap and SH-aLRT

```
iqtree3 -nt <THREADS> -m LG+C60+F+G -msub nuclear -s <INPUT_ALIGNMENT.fasta> -bb 1000 -alrt 1000 -pre <OUTPUT_PREFIX> -ft ,TREE_FROM_STEP2.treefile> -mem <MEMORY_MB>
```

Example script: [20C_Final_IQ_PMSF_Tree.sh](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/blob/main/Scripts/20_IQTree/20C_Final_IQ_PMSF_Tree.sh)

#### 🔍 Parameter Breakdown:
| Parameter       | Description |
|-----------------|-------------|
| `-m LG+C60+F+G` | Use **posterior mean site frequency (PMSF)** model for accuracy |
| `-bb 1000`      | Perform **1,000 ultrafast bootstrap replicates** |
| `-alrt 1000`    | Perform **1,000 SH-aLRT tests** for branch support |
| `-ft`           | Fix the tree topology (from previous step), re-optimize with new model |
| `-mem`          | Set maximum memory usage |

📊 This command produces the **final tree with branch supports**, used in downstream steps like:
- Visualization
- Calibration
- Comparative phylogenetics

---

## 📁 Output Files

- `<OUTPUT_PREFIX>.treefile`: Final best-scoring tree
- `<OUTPUT_PREFIX>.log`: Log file of the IQ-TREE run
- `<OUTPUT_PREFIX>.iqtree`: Model and tree summary

---

## 🧠 Tips

- Use at least **8–16 threads** for optimal performance.
- For large datasets, ensure **enough RAM** is available to load `LG+C60` matrices.
- Combine `-bb` and `-alrt` for strong statistical support at each node.

---

## 📧 Contact

For questions or help running this step, contact:

**Maaike Jacobine Bierenbroodspot**  
📧 maaikejacobine.bierenbroodspot@uni-goettingen.de
