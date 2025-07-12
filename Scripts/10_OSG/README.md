# Step 10: OrthoGroup Sequence Grabber (OSG)

**OSG** is a custom C++ tool developed to filter orthogroups based on user-defined taxonomic groupings. These groupings allow you to emphasize either an ingroup (e.g., your focal lineage) or outgroup, depending on your downstream needs.

By intentionally creating "biased" datasets focused on either the ingroup or outgroup, and then combining them in a later step (e.g., COGS), you can achieve a well-balanced gene set that improves phylogenomic resolution across your entire dataset.

---

## 🔍 Purpose in This Pipeline

For the **Coleochaetophyceae** dataset, we generated two filtered orthogroup sets:

- **Ingroup-biased set** – favors Coleochaetophyceae coverage
- **Outgroup-biased set** – favors outgroup taxon representation

These complementary sets are later merged to provide a strong phylogenetic signal across both ingroup and outgroup lineages.

---

## 📦 OSG Tool Repository

The latest version of **OSG**, along with continued updates, documentation, and feature additions, can be found here:  
🔗 **[OSG GitHub Repository](https://github.com/mjbieren/OrthoGroup_Sequence_Grabber)**

---

## 📜 Scripts for This Step

The commands and parameters used to generate both datasets in this pipeline are available in the following scripts:

- **Ingroup set:**  
  [`10A_OSG_InGroup.sh`](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/blob/main/Scripts/10_OSG/10A_OSG_InGroup.sh)

- **Outgroup set:**  
  [`10B_OSG_Outgroup.sh`](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/blob/main/Scripts/10_OSG/10B_OSG_Outgroup.sh)

---

## 🧩 Ne
