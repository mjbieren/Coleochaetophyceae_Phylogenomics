# 23. AU Test – Tree Topology Testing with IQ-TREE

This analysis performs an **Approximately Unbiased (AU) test** to evaluate the statistical support for alternative phylogenetic hypotheses in the *Coleochaetophyceae* dataset. The AU test was carried out using **IQ-TREE v2**.

---

## 🧬 Purpose

The goal of this step is to statistically test whether constrained trees (topological hypotheses) are significantly worse than the unconstrained maximum likelihood tree using:

- **AU test** (Approximately Unbiased)
- **SH test** (Shimodaira-Hasegawa)
- **KH test** (Kishino-Hasegawa)
- **RELL bootstrap support**
- **Expected Likelihood Weights (c-ELW)**

---

## 📁 Input Files

- `alignment.fas`: concatenated alignment of the final filtered dataset
- `all_trees.nwk`: Newick file containing:
  - The **unconstrained tree** (best ML tree)
  - Multiple **constrained trees** (labeled I through VI) with altered topologies for specific *Coleochaete* clades

---

## ⚙️ Command Used

```bash
iqtree2 -s alignment.fas -z all_trees.nwk -au -m MFP -pre AU_Test_Coleo
```

- `-s alignment.fas`: sequence alignment file
- `-z all_trees.nwk`: set of alternative tree topologies
- `-au`: run AU, SH, KH, WKH, WSH, and c-ELW tests
- `-m MFP`: automatically select the best-fitting model
- `-pre AU_Test_Coleo`: prefix for output files

---

## 📊 Result Summary

### Topology Test Table (From `AU_Test_Coleo.iqtree`)

| Tree ID      | logL          | ΔL       | p-AU         | Significant? |
|--------------|---------------|----------|--------------|--------------|
| Unconstrained| -24453240.12  | 0        | 1+           | ✅ Not rejected |
| I            | -24562906.46  | 109,670  | 9.77e-60     | ❌ Rejected |
| II           | -24473224.66  | 19,985   | 2.85e-166    | ❌ Rejected |
| III          | -24465929.63  | 12,690   | 9.37e-05     | ❌ Rejected |
| IV           | -24465929.63  | 10,047   | 6.5e-60      | ❌ Rejected |
| V            | -24585010.69  | 131,770  | 1.4e-05      | ❌ Rejected |
| VI           | -24460575.61  | 7,336    | 1.71e-70     | ❌ Rejected |

- **All constrained topologies (I–VI)** were significantly rejected (**p-AU < 0.05**)
- The **unconstrained tree** was the only topology not rejected by any test

---

## 🟥 What Was Changed?

The constrained trees I–VI tested specific alternative hypotheses on the branching patterns of *Coleochaete* lineages.

Each tree enforces a different topology, including:
- Modified placement of *C. scutata*, *C. orbicularis*, and *C. nitellarum*
- Rearranged monophyletic groupings based on previous taxonomic expectations

The AU test confirms that **none of the alternative topologies are statistically supported** relative to the unconstrained tree.

---

## ✅ Interpretation

The unconstrained ML tree is **significantly better supported** than any constrained hypothesis. This suggests that:
- The original inferred topology is robust
- Alternative placements of specific *Coleochaete* strains are not statistically justified

---

## 🧠 Tips for Custom AU Testing

- Make sure your **alignment file** is clean and matches taxa in all tree files
- Use consistent taxon labels across all trees
- Label tree topologies clearly (e.g., I, II, III) in your `.nwk` file for clarity in the output

---

## 📚 References

- Shimodaira H. (2002). *An Approximately Unbiased Test of Phylogenetic Tree Selection*. Systematic Biology, 51(3):492–508.
- Minh B.Q., et al. (2020). *IQ-TREE 2: New Models and Efficient Methods for Phylogenetic Inference in the Genomic Era*. MBE.

---

## 📧 Contact

For questions, contact:  
**Maaike Jacobine Bierenbroodspot**  
📧 maaikejacobine.bierenbroodspot@uni-goettingen.de
