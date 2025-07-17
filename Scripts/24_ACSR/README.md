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

All scripts and trait data for the ACSR analysis can be found here:  
🔗 [Scripts/24_ACSR](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/tree/main/Scripts/24_ACSR)

Contents include:
- Trait tables (`*.csv`)
- R scripts for likelihood reconstruction and visualization
- Tree file input (inferred ML tree from previous steps)
- Color palettes and plotting functions

---

## ⚙️ Method Overview

1. **Prepare Trait Data**
   - Traits are scored manually and saved in a `.csv` format.
   - Each row corresponds to a taxon; each column is a character.

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

---

## 🖼 Output

Each character produces:
- A visual tree with state probabilities at each ancestral node
- A log-likelihood score for the model
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
