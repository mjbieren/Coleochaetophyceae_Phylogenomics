# Phylogenomics Unveil Recent Origin of Morphological Complexity in Coleochaetophyceae — Dataset

This repository provides an overview of the tools, scripts, and workflows used in the **Coleochaetophyceae Phylogenomics Project**.

> ⚠️ **Note:** This repository does **not** contain the raw sequencing data used in the study (with minor exceptions). All primary datasets are publicly available via **Zenodo**:  
👉 [https://doi.org/10.5281/zenodo.15376262](https://doi.org/10.5281/zenodo.15376262)

---

## 🧬 Workflow Overview

![Pipeline Diagram](Sources/Images/PhyloRSeqpp_Flow_1000.png?raw=True "Pipeline")

The image above illustrates the full computational pipeline used for transcriptome assembly, orthology inference, alignment, and phylogenomic analysis.

---

## 📘 Introduction

This repository documents the pipeline developed for the **Coleochaetophyceae Phylogenomics Project**, from raw RNA-Seq data acquisition to phylogenetic inference.

---
## 0. RNA-Seq Data Acquisition

RNA-Seq data used in this project originated from two sources:

- **Publicly available datasets** obtained via the NCBI Sequence Read Archive (SRA)
- **In-house generated RNA-Seq libraries** from selected Coleochaetophyceae strains



### 🧫 In-House Strain Cultivation and RNA Extraction

Strains cultivated in-house were grown in **3NBBM medium** ([medium 26a](https://doi.org/10.1111/j.1438-8677.1997.tb00659.x)) under the following conditions:

- Temperature: 18°C  
- Lighting: Full-spectrum fluorescent lamps (25–35 µmol photons m<sup>−2</sup> s<sup>−1</sup>)  
- Light cycle: 14 h light / 10 h dark  

After 6 weeks of growth:

1. **Harvesting**:  
   - 50 mL of culture was centrifuged for 5 min at 20°C at 11,000 rpm.  
   - The supernatant was discarded, and the pellet was transferred to a Tenbroek tissue homogenizer.  
   - Cells were manually disrupted for 10 minutes on ice.

2. **RNA Extraction**:  
   - Total RNA was extracted using the **Spectrum™ Plant Total RNA Kit** (Sigma-Aldrich, Germany), following the manufacturer's protocol.  
   - **DNAse I treatment** (Thermo Fisher, USA) was applied to remove genomic DNA.

3. **Quality Assessment**:  
   - RNA quality was verified on a 1% SDS-stained agarose gel.  
   - Concentration and purity were assessed using a Nanodrop spectrophotometer (Thermo Fisher).

4. **Sample Shipment**:  
   - Purified RNA was shipped on **dry ice** to **Novogene (Munich, DE)** for sequencing.



### 🧬 Library Preparation & Sequencing (Novogene)

At Novogene:

- RNA quality was re-evaluated using a **Bioanalyzer** (Agilent Technologies).
- mRNA libraries were prepared using **polyA enrichment** and **strand-specific (directional) protocols**.
- Sequencing was performed on the **Illumina NovaSeq 6000 platform** using dual-index adapters.

#### Adapter Sequences:

- **Read 1 Adapter**:  
  `5’- AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAGATCTCGGTGGTCGCCGTATCATT -3’`

- **Read 2 Adapter**:  
  `5’- GATCGGAAGAGCACACGTCTGAACTCCAGTCACGGATGACTATCTCGTATGCCGTCTTCTGCTTG -3’`

---

## 1. FastQC & MultiQC
[FastQC](https://github.com/s-andrews/FastQC) ([Simon Andrews](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)) was used as a quality control, as very bad samples (Either from our in-house or downloaded from the SRA set) were then identified to be removed. <br/>For more information on how FastQC was used within the project, go to [01_FASTQC](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/tree/main/Scripts/01_FastQC).</br></br> For more information on FastQC please go to their site http://www.bioinformatics.babraham.ac.uk/projects/fastqc/

---

## 2. Trinity *de novo* Assembly
After FastQC quality control, all samples were then assembled with the Trinity pipeline. <br/>First, the adapters were trimmed with [Trimmomatic](https://github.com/usadellab/Trimmomatic) ([A. M Bolger et al_2014](https://academic.oup.com/bioinformatics/article/30/15/2114/2390096)) with the settings:
```
-trimmomatic “novogene_adapter_sequences.fa:2:30:10:2:keepBothReads LEADING:3 TRAILING:3 MINLEN:36”
```

Followed by running [Trinity](https://github.com/trinityrnaseq/trinityrnaseq) ([Haas *et al* 2013](https://www.nature.com/articles/nprot.2013.084)) with the command 
```
Trinity --seqType fq --left [LEFT_READS] --right [RIGHT_READS] --output [OUTPUT_FOLDER] --SS_lib_type RF --CPU 48 --trimmomatic --full_cleanup --max_memory 350G --quality_trimming_params  "ILLUMINACLIP:novogene_adapter_sequences.fa:2:30:10:2:keepBothReads LEADING:3 TRAILING:3 MINLEN:36"
```
I highly recommend reading Trinity's [Wiki site](https://github.com/trinityrnaseq/trinityrnaseq/wiki), which explains everything pretty well.<br/><br/>

See [02_Trinity](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/tree/main/Scripts/02_Trinity) for a more in-depth overview of what we did.

---

## 3. SuperTranscripts
[SuperTranscripts](https://github.com/trinityrnaseq/trinityrnaseq/wiki/SuperTranscripts) ([Davidson *et al* 2017](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-017-1284-1)) et al. was inferred by collapsing splicing isoforms using the Trinity implementation. <br/>See [SuperTranscripts](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/tree/main/Scripts/03_SuperTranscript) for a more in-depth overview of what we did.

---

## 4. BUSCO I
To assess the quality and completeness of our assemblies, we ran [BUSCO](https://busco.ezlab.org/) ([Seppey *et al.*, 2019](https://link.springer.com/protocol/10.1007/978-1-4939-9173-0_14)) using the `eukaryota_odb10` reference dataset.

For a detailed description of the procedure and scripts used, please refer to the [04_BUSCO_I](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/tree/main/Scripts/04_BUSCO_I) directory.

---

## 5. Protein Prediction with TransDecoder

After generating the SuperTranscripts and confirming their completeness exceeds the 70% threshold, we proceeded to predict protein-coding sequences using [TransDecoder](https://github.com/TransDecoder/TransDecoder/wiki) ([Haas, BJ](https://github.com/TransDecoder/TransDecoder)).

The main steps involved were:

1. Extracting long open reading frames (ORFs) using `TransDecoder.LongOrfs`.
2. Predicting the most likely coding regions while retaining only BLASTP-supported hits, applying the `--single_best_only` option to keep a single, high-confidence prediction per transcript.

For a detailed overview of the commands and workflow, see the [05_TransDecoder](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/tree/main/Scripts/05_TransDecoder) directory.

---

## 6. BUSCO II
As an additional quality control step, we reran BUSCO to verify that the completeness of the assemblies remained above the 70% threshold. This check was necessary because applying the `--single_best_only` option in TransDecoder occasionally resulted in a slight decrease in completeness scores.

For a detailed overview of this step, please refer to the [06_BUSCO_II](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/tree/main/Scripts/06_BUSCO_II) directory.

---

## 7. Decontamination

### Setting Up the Decontamination

To eliminate potential contaminants from the protein sets, we conducted sequence similarity searches using [MMseqs2](https://github.com/soedinglab/MMseqs2)([Steinegger and Söding 2017](https://www.nature.com/articles/nbt.3988)).  
We created a comprehensive reference database that included:

- **Positive Set:**  
  *Coleochaete scutata* strain SAG 110.80Mneu ([https://sagdb.uni-goettingen.de/](https://sagdb.uni-goettingen.de/)) As this is the only axenic strain.
  
- **Negative Sets:**  
  - Representative **bacterial** genomes (43,588 genomes)  
  - **Fungal** genomes (1,225)
  - **Invertebrate** genomes (7,213)
  - **Protozoa** genomes (893)
  - **Archaeal** genomes (1,120)  
  - All available **viral** proteins  (655,246 sequences)
  - **Mitochondrion** proteins (240,117 sequences)
  - **Plastid** proteins (1,064,130 sequences)
  - **Plasmid** proteins (2,080,798 sequences)

> ✅ All negative datasets were downloaded from RefSeq (7 July 2023).

We used an iterative MMseqs2 search strategy with increasing sensitivity:

```
--start-sens 1 --sens-steps 3 -s 7 --alignment-mode 3 --max-seqs 10
```
This produces a `.outfmt6`-formatted file, which resembles standard BLAST tabular output and serves as input for the next filtering step.

👉 For more detailed instructions and example scripts, see:  
[**07_Decontamination**](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/tree/main/Scripts/07_Decontamination)


### Get Positive Data Set (GPDS)

To extract only the sequences that match the **positive reference set**, we used a custom tool: [**GPDS**](https://github.com/mjbieren/GPDS/).  
This tool:

- Extracts FASTA entries that matched the positive set (*Coleochaete scutata* SAG 110.80Mneu, in our case)
- Outputs separate FASTA files for positive and contaminant matches
- Summarizes contamination levels (% removed per strain)

This step ensures that only high-confidence, taxonomically relevant sequences are retained for downstream orthology and phylogenomic analyses.

---

## 8. BUSCO III
The decontamination step is designed to be stringent, prioritizing the removal of potential contaminants over the risk of generating false positives. As a result, while it's effective at cleaning up the data, it can also lead to false negatives, where genuine sequences are mistakenly filtered out.
Before we proceed to inferring gene families (orthogroups) with OrthoFinder, we want to verify the completeness of the transcriptomes after decontamination. Some drop in completeness is expected, given how the filtering works. However, this step helps us identify any samples that may have lost too much genomic content to be useful as we advance.
See [08_BUSCO_III](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/tree/main/Scripts/08_BUSCO_III) for more information.

---

## 9. OrthoFinder – Orthogroup Inference

In this step, we use [OrthoFinder](https://github.com/davidemms/OrthoFinder) ([Emms & Kelly, 2019](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-019-1832-y)) to infer **orthogroups** from the transcriptome assemblies.

The analysis includes all high-quality, post-decontamination samples, along with selected outgroups. A precomputed species tree is provided to guide the inference process and improve the accuracy of orthology assignment.

📂 For a detailed overview of the workflow, parameters, and input structure, see the script and documentation in:
[Scripts/09_OrthoFinder](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/tree/main/Scripts/09_OrthoFinder)

---

## Step 10: OrthoGroup Sequence Grabber (OSG)

The **[OrthoGroup Sequence Grabber (OSG)](https://github.com/mjbieren/OrthoGroup_Sequence_Grabber)** is a custom tool developed to extract all FASTA blocks (i.e., FASTA headers and sequences) corresponding to each orthogroup. The tool allows for flexible filtering based on a user-defined minimum number of taxonomic groups per orthogroup, ensuring that only well-represented gene families are selected for downstream analysis.

📂 For detailed usage and implementation, see the full script and documentation:  
[Scripts/10_OrthogroupSequenceGrabber_OSG](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/blob/main/Scripts/10_OrthogroupSequenceGrabber_OSG)


### 🧪 Output Overview

The pipeline produces **two distinct datasets** from OSG:

1. **Outgroup Set**  
2. **Ingroup Set**

These datasets are later combined during the **COGS** step to ensure balanced representation of both ingroup and outgroup taxa in the final alignment.


### ❓ Why Two Datasets?

From previous projects (e.g., [Klebsormidiophyceae Phylogenomics](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae)), we observed that filtering orthogroups based on taxonomic group presence can introduce bias.  
- Favoring **ingroup taxa** may reduce **outgroup support**.
- Favoring **outgroup taxa** may weaken **ingroup resolution**.

By generating and then **combining** both sets, we typically achieve **stronger branch support across the entire phylogenomic tree**, including ancestral nodes.


### 🌐 Dataset Details

#### 🔹 Outgroup Set

The dataset that favors the outgroups of the dataset

- **Taxonomic group file:**  
  [`Coleocheatephyceae_TaxonomicGroupFile_Outgroup_set.txt`](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/blob/main/Scripts/10_OSG/TaxonomicGroupFiles/Coleocheatephyceae_TaxonomicGroupFile_Outgroup_set.txt)

- **Threshold:**  
  Minimum of 10 out of 14 taxonomic groups required per orthogroup.


#### 🔹 Ingroup Set

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
---

## 11. MIAF – Mafft and IQ-TREE All Fasta Files

Once orthogroups have been identified, it's common to observe **paralogs** within these groups. To refine these orthogroups for downstream phylogenetic analysis, we use **PhyloPyPruner**, which requires precomputed multiple sequence alignments and gene trees.

This step prepares the data for PhyloPyPruner by:

- Aligning all protein sequences in a directory using **MAFFT**
- Building maximum likelihood trees with **IQ-TREE**

To automate this process across many FASTA files, we use the job manager **[MIAF](https://github.com/mjbieren/MIAF)** (Mafft and IQtree All Fasta files).

MIAF performs the following:
- Iterates through each FASTA file in a directory
- Runs MAFFT to align sequences
- Runs IQ-TREE to infer gene trees
- Supports high-performance cluster usage for parallel processing


### How to Use MIAF

You can find full instructions and example usage here:  
👉 [11_MIAF](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/tree/main/Scripts/11_MIAF)

Ensure that both **MAFFT** and **IQ-TREE** are installed and accessible in your environment (Or use executables).


### Output

- The directory "Fasta_Files_Processed" with the processed (original) fasta files
- The directory "MSA_Trees" with the MSA files and corresponding tree files (newick format)



---

## 12. Apply PhyloPyPruner Format (APPPFormat)

Before pruning gene trees with **PhyloPyPruner**, the Newick tree files produced by **IQ-TREE** must be reformatted. This is because IQ-TREE alters the alignment headers during tree construction, removing species-strain delimiters (e.g., replacing `@` with `_`). The [**APPPFormat**](https://github.com/mjbieren/ApplyPPPFormat/tree/main) tool restores the correct format to these tree tips, ensuring compatibility with PhyloPyPruner.

This step prepares all required inputs for the next pruning step using [PhyloPyPruner](https://github.com/davidemms/PhyloPyPruner).


### 🔧 What APPPFormat Does

- Reformats Newick tree files to comply with PhyloPyPruner requirements.
- Restores proper species/strain delimiters using a taxonomic group file.
- Moves reformatted tree files to an output folder.
- Optionally copies and renames MAFFT alignment files (`.mafft → .fa`).

### 📁 Input Requirements

- Tree files in Newick format (e.g., `.treefile` output from IQ-TREE).
- **Taxonomic group file** with species/strain format (see [examples](https://github.com/mjbieren/ApplyPPPFormat/tree/main/TaxonomicGroupFiles)).
- Optional: Corresponding `.mafft` alignment files for each tree.


### ▶️ How to Use

1. Edit and run the `APPPFormat.sh` script:
   - [`APPPFormat.sh`](https://github.com/mjbieren/ApplyPPPFormat/blob/main/APPPFormat.sh)

2. Example command structure:
   ```
   APPPFormat.out -i [PathToTrees] -t [TreeFileExtension] -g [TaxonomicGroupFile] -r [OutputFolderPath] -m [PathToMafftFiles (optional)]
   ```

For an overview of how we did it and example scripts for this project, go to [12_APPPF](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/tree/main/Scripts/12_APPPF)

----

## 13. PhyloPyPruner – Prune Orthogroups

In this step, we prune **paralogs** from each orthogroup to retain only **one representative gene per species**. This results in a refined dataset suitable for downstream phylogenomic analyses.

We use [**PhyloPyPruner**](https://pypi.org/project/phylopypruner/), a tool that infers orthologous relationships based on gene trees, to remove paralogs and retain high-confidence orthologs across all taxa.


### 🧬 Input

- Reformatted alignment and tree files produced in step 12 using [APPPFormat](https://github.com/mjbieren/ApplyPPPFormat).
- Taxonomic group file.
- Parameters tailored to the dataset and taxonomic scope.


## 🧪 Output

- Pruned FASTA files with **one ortholog per species**.
- Summary statistics on pruned orthogroups and retained sequences.



## 📎 More Information

- For further details and context what settings we used during this project, see the full [13_PPP](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/tree/main/Scripts/13_PPP)
- Learn more about the tool on [Phylopypruner](https://github.com/fethalen/phylopypruner) 

---

## 14. Filter the PhyloPyPruner Result
After Phylopypruner, we have to filter the result. This is due to the fact that how Phylopypruner works and basically prunes parts of the tree and creates sub-OrthoGroup files. E.g. N2_OG0000001**\_1**.fa and NN2_OG0000001**\_2**.fa. These files can have a low and high amount of species, but can underrepresent the taxonomic groups. Hence, we have to filter it again, to remove the ones that are below the Taxonomic Group threshold. For this we've created a tool called FilterPPPResult.out. Like OSG it takes a Taxonomic group file and filters the Files out that do not meet the Threshold. Furthermore, it can remove the Gene IDs (keep only the strain name) and remove the alignments from the sequences, which is needed for the PREQUAL step (later in the Pipeline).
Different Taxonomic Group files and thresholds were used for the 2 different sets.
1. Old Set: [Klebsormidiophyceae_TaxonomicGroupFile_3_Taxa_PrequalFilter.txt](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/blob/main/Scripts/10_OrthogroupSequenceGrabber_OSG/TaxonomicGroupFiles/Klebsormidiophyceae_TaxonomicGroupFile_3_Taxa_PrequalFilter.txt) with a 2 Threshold (2/3)
2. New Set: [Klebsormidiophyceae_TaxonomicGroupFile_40_Taxa_AfterPPP_Tax21Set_AndCombinedSet.txt](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/tree/main/Scripts/10_OrthogroupSequenceGrabber_OSG/TaxonomicGroupFiles#:~:text=Klebsormidiophyceae_TaxonomicGroupFile_40_Taxa_AfterPPP_Tax21Set_AndCombinedSet.txt) with a 21 Threshold (21/40)

Scripts execution is the same for both.

See [FilterPPPResult](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/tree/main/Scripts/14_FilterPhylopypruner) for a more in-depth overview of what we did.


## 15. Combine OrthoGroup Sets
After looking at the results of both sets, we concluded that the Old set was good for the out-groups but bad for the in-groups, and the new set was good for the in-groups but bad for the out-groups. We then decided to combine the Orthogroups of both sets together and restart the process from step 11. Another tool was created to just do that, which is called COGS.out (Combine OrthoGroup Sets). It uses the OrthoFinder output from Step 9, And the Fasta Output Folder path from Step 14 for both sets. It then automatically obtains the OrthoGroup names and references that back based on the OrthoFinder output .tsv files And obtains the corresponding Fasta Blocks like OSG does. 

See [CombineOrthoGroupSets_COGS](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/tree/main/Scripts/15_CombineOrthoGroupSets_COGS) for a more in-depth overview of what we did.

## 16. MAFFT/IQTree 
See step 11

## 17. Filter PPP Script 2
See Step 12

## 18. PhyloPyPruner
We did the same as step 13. We used the same parameters for the combined set as we did for the New Set: [PhyloPruner_I_Conda_Gandalf_CombinedSetTax21_New1.sh](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/blob/main/Scripts/13_Phylopypruner/Scripts/13_Phylopypruner/PhyloPruner_I_Conda_Gandalf_CombinedSetTax21_New1.sh). 

## 19. Filter the PhyloPyPruner Result
We did the same as in step 14, however, we used the Taxonomic Group file: [TaxonomicGroupFiles/Klebsormidiophyceae_TaxonomicGroupFile_4_Taxa.txt](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/blob/main/Scripts/10_OrthogroupSequenceGrabber_OSG/TaxonomicGroupFiles/Klebsormidiophyceae_TaxonomicGroupFile_4_Taxa.txt) with a 2 Threshold (2/4)

This way we filter out the OrthoGroup-sub files that are of irrelevance.

Furthermore, in this step, we also added the parameters -a -h, To remove the Gene IDs and the Gaps from the alignments since we need to realign the files with a different method in step 20.

## 20. PREQUAL
This step is needed since we want to remove the non-informative sites from each alignment file. So that when we concatenate all the files in one big alignment without having a lot of "noise". <br/>
During this step, multiple programs were run:
1. [PREQUAL](https://github.com/simonwhelan/prequal) ([Simon Whelan *et al* 2018](https://academic.oup.com/bioinformatics/article/34/22/3929/5026659))
2. [ginsi](https://mafft.cbrc.jp/alignment/software/) ([K. Katoh and D.M. Standley 2013](https://academic.oup.com/mbe/article/30/4/772/1073398))
3. [IQTree](http://www.iqtree.org/) ([Bui Quang Minh *et al* 2020](https://academic.oup.com/mbe/article/37/8/2461/5859215))
4. [ClipKIT](https://github.com/JLSteenwyk/ClipKIT) ([J.L. Steenwijk *et al* 2020](https://journals.plos.org/plosbiology/article?id=10.1371/journal.pbio.3001007)<br/>
See [Prequal](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/tree/main/Scripts/16_Prequal) for a more in-depth overview of what we did.

## 21. Concatenating alignments file.
We did this step to concatenate all the alignments. We used [Phyx](https://github.com/FePhyFoFum/phyx) ([JW Brown *et al* 2017](https://academic.oup.com/bioinformatics/article/33/12/1886/2975328)) a tool that performs phylogenetic analysis on trees and sequences.

See [ConcatenateSequences](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/tree/main/Scripts/17_ConcatenateSequences) for a more in-depth overview of what we did.

## 22 ClipKIT
After looking at the concatenated alignment we confirmed that there were still a lot of non-informative sites within the sequences. That is why we run ClipKIT with the option -g 0.65. <br/>
We used 65, because any lower, we removed too many informative sites,  and higher, we had too many non-informative sites. This can be different from yours so play a bit around with the value to find the optimum for you.

See [ClipKIT](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/tree/main/Scripts/18_Clipkit) for a more in-depth overview of what we did.

## 23 ModelFinder
To determine what the best tree model for our concatenated alignment was, we ran [ModelFinder](http://www.iqtree.org/ModelFinder/) ([S Kalyaanamoorthy *et al* 2017](https://www.nature.com/articles/nmeth.4285) with  IQtree V1.6.12. See [IQtree Exectuables](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/tree/main/Executables/IQTree)
```
iqtree -nt 20 -m TESTONLY -madd LG+C60 -msub nuclear -s [AlignmentFileInput]
```

According to the result (See [ModelFinder Results](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/tree/main/Scripts/19_IQTree/Examples/ModelFinder)) LG+C60 was the best fitting model for our alignment so this was used in step 24.


## 24 IQTree
After step 3, we then placed the model into the script and started IQTree with the parameters: (we use IQTree V2.0.6 for this step. See [IQtree Exectuables](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/tree/main/Executables/IQTree) )
```
iqtree2 -nt 50 -m LG+C60 -msub nuclear -s [Alignment_File_Output_Step22] -bb 1000 -alrt 1000 -pre [Your_Choice_Of_Prefix_For_Output_File]
```
On the result of the step above, we then perform a posterior mean site frequency (PMSF)  as a rapid and efficient approximation to a full empirical profile mixture model for ML analysis ([H.C. Wang _et al_](https://academic.oup.com/sysbio/article/67/2/216/4076233) ).

```
iqtree2 -nt 20 -m LG+C60+F+G -msub nuclear -s [Alignment_File_Output_Step22] -bb 1000 -alrt 1000 -pre [Your_Choice_Of_Prefix_For_Output_File] -ft [Result_Step_Above]
```

>[!NOTE]
>Furthermore, we also used the LG+F+I+G model since that was the initial tree model from the old set. However, after running PMSF on that tree output, the resulting tree of the PMSF is the same as the result above. (results not shown)

# Ancestor Character State Reconstruction
After the pipeline, we use the tree to do some Ancestor Character State Reconstruction with the R package [phytools](https://github.com/liamrevell/phytools) ([L.J. Revell 2012](https://besjournals.onlinelibrary.wiley.com/doi/10.1111/j.2041-210X.2011.00169.x) based on different states (morphology, habitat, occurrence) per species.<br/><br/>
See [ACSR](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/tree/main/ACSR) for more information on how we did this.


# Notes for future development
I plan to develop a fully functional C++ tool pipeline in the future. This project was meant as a simple in and output project and it became so much more than that.
The goal is to enter only the RNA-seq data (and related information) and a guide tree and let the program handle the rest so that people who are not skilled in bioinformatics can run it themselves.
Either with the help of a High-Performance Cluster or a single High-Performance machine.


# Citing
If you use anything within this repository, please cite
```
Maaike J. Bierenbroodspot, Tatyana Darienko, Sophie de Vries, Janine M.R. Fürst-Jansen, Henrik Buschmann, Thomas Pröschold, Iker Irisarri, Jan de Vries. Phylogenomic insights into the first multicellular streptophyte. bioRxiv [Preprint. 2023 Nov 1: 2023.11.01.564981. doi: 10.1101/2023.11.01.564981
```
