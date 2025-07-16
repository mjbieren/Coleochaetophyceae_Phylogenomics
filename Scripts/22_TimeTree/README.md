
#22. MCMCTree – Time Tree Estimation

This guide describes how to run **MCMCTree** (from the [PAML](http://abacus.gene.ucl.ac.uk/software/paml.html) package) to estimate divergence times using a relaxed molecular clock, a maximum likelihood tree, and calibration constraints.

---

## 📁 Step 1: File Preparation

### 1.1. Add Tree Header
Ensure your Newick tree file has a header indicating one tree:

```text
1 48
```

- `1` = number of trees
- `48` = number of taxa

Add this to the top of the `.treefile` to ensure it's readable by MCMCTree.

---

### 1.2. Convert Alignment to Relaxed PHYLIP Format

Use [`fasta2relaxedPhylip.pl`](https://github.com/npchar/Phylogenomic/blob/master/fasta2relaxedPhylip.pl) to convert your alignment:

```bash
perl fasta2relaxedPhylip.pl -f Coleo_Tax10_COGS_Concat.fas -o Coleo_Tax10_COGS_Concat.rphy
```

**Fix formatting issues**:
- Replace all **tabs** with **spaces**.
- First line should be:  
  ```
  [number of loci] [number of species]
  ```
- No extra tabs/spaces at the start of lines.

---

## 🧾 Step 2: Define Calibration Constraints

Edit your `.treefile` by tagging calibrated nodes using `#`.

Example:
```text
((A,B):1#1,C):1#2;
```

In your `mcmctree.ctl`, define calibrations like:

```text
1  B(4.69,18.91,1e-300,0.001)
2  B(4.69,18.91,1e-300,0.001)
...
```

**Calibration examples**:
- Streptophyte / Chlorophyte: `B(4.69,18.91,1e-300,0.001)`
- Chara / Nitella: `B(4.69,4.8,1e-300,0.001)`
- Azolla / Arabidopsis: `B(3.8557,4.51,1e-300,0.001)`
- See full list in comments above.

---

## 🧪 Step 3: Step 1 Run – Gradient & Hessian Estimation

### 3.1. Prepare `mcmctree.ctl` (Step 1 config)
Example:

```text
seed = -1
seqfile = Coleo_Tax10_COGS_Concat.rphy
treefile = TreeForFile_Coleo.txt
outfile = Coleo_MCMCTree_Set2_Step1.out

ndata = 1
seqtype = 2
usedata = 3
clock = 2
RootAge = 4.9

model = 0
alpha = 0
ncatG = 5
cleandata = 0

BDparas = 1 1 0.1
kappa_gamma = 6 2
alpha_gamma = 1 1
rgene_gamma = 2 4.5
sigma2_gamma = 2 2

finetune = 1: 0.1 0.1 0.1 0.01 0.5

print = 1
burnin = 20000
sampfreq = 5000
nsample = 100000000
```

### 3.2. Run MCMCTree (Step 1)

```bash
mcmctree mcmctree.ctl
```

This generates the `out.BV` file for Step 2.

---

## ⚙️ Step 4: Estimate Hessian Using codeml

### 4.1. Copy Files to New Directory
Copy from Step 1:
- `tmp0001.ctl`
- `tmp0001.out`
- `tmp0001.trees`
- `tmp0001.txt`
- `wag.dat` (from PAML)

### 4.2. Prepare codeml Control File

Edit `tmp0001.ctl`:

```text
seqfile = tmp0001.txt
treefile = tmp0001.trees
outfile = tmp0001.out
noisy = 3

seqtype = 2
model = 2
aaRatefile = wag.dat

fix_alpha = 0
alpha = 0.5
ncatG = 4
Small_Diff = 0.1e-6

getSE = 2
method = 1
```

### 4.3. Run codeml

```bash
codeml tmp0001.ctl
```

### 4.4. Copy `rst2` to Step 2 Folder

```bash
cp rst2 in.BV
```

---

## ⏱️ Step 5: Step 2 Run – MCMC Tree Estimation

Edit `mcmctree.ctl` to switch to `usedata = 2`:

```text
usedata = 2
```

Ensure `in.BV`, sequence file, and tree are present.

Run:

```bash
mcmctree mcmctree.ctl
```

---

## 📊 Step 6: Visualize and Interpret

- Use **Tracer** to check ESS values and convergence:  
  https://beast.community/tracer

- Visualize the final time tree using:
  - [FigTree](http://tree.bio.ed.ac.uk/software/figtree/)
  - [iTOL](https://itol.embl.de)
  - `ggtree` in R

---

## 🧠 Tips

- Always double-check species names match across tree and alignment.
- Use `screen` or `tmux` for long jobs.
- Consider multiple independent runs to verify convergence.

---

## 📧 Contact

For questions, contact:

**Maaike Jacobine Bierenbroodspot**  
📧 maaikejacobine.bierenbroodspot@uni-goettingen.de
