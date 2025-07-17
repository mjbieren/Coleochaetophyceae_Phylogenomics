# 24. Ancestral Character State Reconstruction (ACSR)

This step involves inferring **ancestral states** of discrete characters across the phylogeny using a **maximum likelihood approach** under **symmetric transition models**. The goal is to reconstruct the evolutionary history of key morphological or ecological traits in *Coleochaetophyceae*.

---

## 🔍 Purpose

To determine how traits have evolved over time across the phylogeny, we use ancestral character state reconstruction. This analysis provides insight into:
- Trait polarity
- Evolutionary gains/losses
- Transitional states across lineages

---

## 🧬 Model

We use a **symmetric model**:
- All transitions between different states are equally probable.
- Suitable for unordered categorical traits.
- No directional or asymmetric bias is assumed.

Each character (trait) may have a different number of possible states, but the same symmetric logic applies across all reconstructions.

---

## 📁 Scripts & Data

All scripts and trait data for the ACSR analysis can be found here:  🔗 [R_Scripts](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/tree/main/Scripts/24_ACSR/R_Scripts)

Contents include:
- Trait tables (`*.tsv`)
- R scripts for likelihood reconstruction and visualization
- Tree file input (inferred ML tree from previous steps)
- Color palettes and plotting functions

---

## ⚙️ Method Overview

1. **Prepare Trait Data**
   - Traits are scored manually and saved in a `.tsv` format.
   - Each row corresponds to a taxon; each 2nd column is a character state.

2. **Load Tree and Traits in R**
   - Tree must be ultrametric and labeled with matching species names.
   - Characters are loaded as factors.

3. **Run ACSR Using `ace()`**
   - Function used: `ape::ace()`
   - Method: `"ML"`
   - Model: `"SYM"` (symmetric)

4. **Visualize**
   - Pie charts at internal nodes show proportional likelihoods of ancestral states.
   - Optional: highlight nodes of interest, root states, or transitions.

### 🧪 R Script Example

```r
library("phytools")

# Load tree
tree <- read.newick("SIMPLIFIED_Final_IQ_Tree_Coleo_PMSF_Tax15_Loci2924_PreLGIG4.nwk")
plotTree(tree, fsize=0.8, ftype="i")

# Load and prepare trait data
x <- read.table("Coleo_Present_Of_Hairs_2.txt", row.names=1)
x <- as.matrix(x)

# Define state colors
cols <- c("#FFBE0B", "#8338EC")

# Visualize trait distribution on tips
tiplabels(pie=to.matrix(x, sort(unique(x))), piecol=cols, cex=0.2)
add.simmap.legend(colors=cols, prompt=FALSE, x=0.9*par()$usr[1],
                  y=-max(nodeHeights(tree)), fsize=0.8)

# Define symmetric model (equal transition rates)
transitions <- matrix(c(0, 1, 1, 0), nrow=2)

# Fit ancestral states
fitORDERED <- ace(x, tree, type="discrete", model=transitions)

# Visualize ancestral states as pie charts
plotTree(tree, fsize=0.8, ftype="i")
nodelabels(node=1:tree$Nnode + Ntip(tree),
           pie=fitORDERED$lik.anc, piecol=cols, cex=0.5)
tiplabels(pie=to.matrix(x, sort(unique(x))), piecol=cols, cex=0.2)

#Print the probabilities to screen
print(fitORDERED$lik.anc)

#Which node is what
plotTree(tree,fsize=0.8,ftype="i",node.numbers=TRUE)

```


---

## 🖼 Output

Each character produces:
- A visual tree with state probabilities at each ancestral node
- A log-likelihood score for the probabilities
- A summary of reconstructed node states (with marginal probabilities)

---

## 📚 Tools & Packages Used

- [`ape`](https://cran.r-project.org/package=ape)
- [`phytools`](https://cran.r-project.org/package=phytools)
- Custom R scripts for color management and tree plotting

---

## 🧠 Notes

- Tip labels in the tree **must match** the names used in the trait data file.
- Missing or ambiguous data is excluded from likelihood calculation.
- If needed, reroot the tree using `phytools::reroot()` before running `ace()`.

---

## 📧 Contact

For issues, suggestions, or questions:  
**Maaike Jacobine Bierenbroodspot**  
📧 maaikejacobine.bierenbroodspot@uni-goettingen.de
