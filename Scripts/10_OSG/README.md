# Step 10: OrthoGroup Sequence Grabber (OSG)

**OSG** is a custom C++ tool developed to filter orthogroups based on user-defined taxonomic groupings. These groupings allow you to emphasize either an ingroup (e.g., your focal lineage) or outgroup, depending on your downstream needs.

By intentionally creating "biased" datasets focused on either the ingroup or outgroup, and then combining them in a later step (e.g., COGS), you can achieve a well-balanced gene set that improves phylogenomic resolution across your entire dataset.

OSG uses all the "Phylogenetic Hierarchical Orthogroup" files (N0.tsv .. Nn.tsv) files within a directory but it is recommended to only use the N0.tsv file instead.

>[!NOTE]
>From OrthoFinder v3.1.0, N0.tsv is removed from /Phylogenetic_Hierarchical_Orthogroups. Instead, Orthogroups/Orthogroups.tsv contains the orthogroups from N0.tsv.

OSG uses 
---

## 🔍 Purpose in This Pipeline

For the **Coleochaetophyceae** dataset, we generated two filtered orthogroup sets:

- **Ingroup-biased set** – favors Coleochaetophyceae coverage
- **Outgroup-biased set** – favors outgroup taxon representation

These complementary sets are later merged to provide a strong phylogenetic signal across both ingroup and outgroup lineages.

---

## 🌐 Dataset Details

### 🔹 Outgroup Set

The dataset that favors the outgroups of the dataset

- **Taxonomic group file:**  
  [`Coleocheatephyceae_TaxonomicGroupFile_Outgroup_set.txt`](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/blob/main/Scripts/10_OSG/TaxonomicGroupFiles/Coleocheatephyceae_TaxonomicGroupFile_Outgroup_set.txt)

- **Threshold:**  
  Minimum of 10 out of 14 taxonomic groups required per orthogroup.


### 🔹 Ingroup Set

The dataset that favors the ingroup of the dataset (Aka the Coleochaetophyceae species)

- **Taxonomic group file:**  
  [`Coleocheatephyceae_TaxonomicGroupFile_Ingroup_Set.txt`](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/blob/main/Scripts/10_OSG/TaxonomicGroupFiles/Coleocheatephyceae_TaxonomicGroupFile_Ingroup_Set.txt)

- **Threshold:**  
  Minimum of 2 out of 4 taxonomic groups required per orthogroup.


### 🚀 Running the Tool

You can execute the OSG program with a command like:

```
OSG.out -g [ORTHOGROUP_DIR] -f [FASTA_DIR] -g [TaxonomicGroupFile.txt] -t [THRESHOLD] -r [OUTPUT_DIR]
```

## 📜 Scripts for This Step

The commands and parameters used to generate both datasets in this pipeline are available in the following scripts:

- **Ingroup set:**  
  [`10A_OSG_InGroup.sh`](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/blob/main/Scripts/10_OSG/10A_OSG_InGroup.sh)

- **Outgroup set:**  
  [`10B_OSG_Outgroup.sh`](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/blob/main/Scripts/10_OSG/10B_OSG_Outgroup.sh)

---

## 📦 OSG Tool Repository

The latest version of **OSG**, along with continued updates, documentation, and feature additions, can be found here:  
🔗 **[OSG GitHub Repository](https://github.com/mjbieren/OrthoGroup_Sequence_Grabber)**

---




