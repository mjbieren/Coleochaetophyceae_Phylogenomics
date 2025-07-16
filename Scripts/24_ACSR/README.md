# 24. Ancestral Character State Reconstruction (ACSR)

For the Coleochaetophyceae, we aimed to conduct an **Ancestral Character State Reconstruction (ACSR)**on several key characteristics, specifically for the Coleochaetophyceae phylogenomics project.

## Overview

ACSR is used here to infer ancestral states across phylogenetic trees by analyzing character evolution. Our approach employs **symmetric models** with **different discrete character states**, reflecting the traits of interest in the Coleochaetophyceae lineage.

## Key Features

- Uses **symmetric transition models** for state changes.
- Handles **multiple distinct states** relevant to the dataset.
- Tailored for phylogenomic data from the Coleochaetophyceae set.

## Relevant data location

All relevant scripts and resources can be found at:

[https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/tree/main/Scripts/24_ACSR](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/tree/main/Scripts/24_ACSR)

## Usage

1. Input files should include:  
   - Phylogenetic tree(s) in Newick format.  
   - Character state data for taxa (discrete states).  
2. Run the scripts to:  
   - Perform ancestral state estimation under symmetric models.  
   - Visualize or export reconstructed states.

Specific instructions and dependencies can be found in the individual script headers.

## Requirements

- Need to install the [phytools](https://cran.r-project.org/web/packages/phytools/index.html) package

## Notes

- This implementation assumes **symmetric transition rates** between states.  
- Different character states are discrete and non-ordered.  
- Designed for and tested on Coleochaetophyceae phylogenomic data.


