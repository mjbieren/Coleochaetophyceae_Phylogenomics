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

---

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

---

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

## 3. SuperTranscripts
[SuperTranscripts](https://github.com/trinityrnaseq/trinityrnaseq/wiki/SuperTranscripts) ([Davidson *et al* 2017](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-017-1284-1)) et al. was inferred by collapsing splicing isoforms using the Trinity implementation. <br/>See [SuperTranscripts](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/tree/main/Scripts/03_SuperTranscript) for a more in-depth overview of what we did.

## 4. BUSCO I
To assess the quality and completeness of our assemblies, we ran [BUSCO](https://busco.ezlab.org/) ([Seppey *et al.*, 2019](https://link.springer.com/protocol/10.1007/978-1-4939-9173-0_14)) using the `eukaryota_odb10` reference dataset.

For a detailed description of the procedure and scripts used, please refer to the [04_BUSCO_I](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/tree/main/Scripts/04_BUSCO_I) directory.


## 5. Protein Prediction with TransDecoder

After generating the SuperTranscripts and confirming their completeness exceeds the 70% threshold, we proceeded to predict protein-coding sequences using [TransDecoder](https://github.com/TransDecoder/TransDecoder/wiki) ([Haas, BJ](https://github.com/TransDecoder/TransDecoder)).

The main steps involved were:

1. Extracting long open reading frames (ORFs) using `TransDecoder.LongOrfs`.
2. Predicting the most likely coding regions while retaining only BLASTP-supported hits, applying the `--single_best_only` option to keep a single, high-confidence prediction per transcript.

For a detailed overview of the commands and workflow, see the [05_TransDecoder](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/tree/main/Scripts/05_TransDecoder) directory.


## 6. BUSCO II
Another quality control is to determine if we still are above the completeness threshold (70%). This is because we used the single best option, and some of the completeness values dropped a bit. <br/><br/>
See [BUSCO_II](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/blob/main/Scripts/06_BUSCO_II/README.md) for a more in-depth overview of what we did.

## 7. Decontamination
### Setting up the Decontamination
To remove potential contaminants, we conducted sequence similarity searches against a comprehensive database that included proteins from various sources. Which were a positive set [*Klebsormidium nitens* NIES-2285](https://www.nature.com/articles/ncomms4978) and 4 potential contaminants through the RefSeq (downloaded on 17 Augustus 2020) representative bacterial genomes (11,318 genomes), fungi (2,397), all available viruses, archaea (1,833), and plastid genes (78,2087) (downloaded on 3 April 2023). We use this database to employ [MMseqs2](https://github.com/soedinglab/MMseqs2) ([Steinegger and Söding 2017](https://www.nature.com/articles/nbt.3988)) for the search, using an iterative approach with increasing sensitivities and maintaining a maximum of 10 hits 
```
--start-sens 1 --sens-steps 3 -s 7 --alignment-mode 3 --max-seqs 10). 
```

This will give a blast output file in the .outfmt6 format. <br/><br/>
See [Decontamination](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/tree/main/Scripts/07_Decontamination) for a more in-depth overview of what we did.

### Get Positive Data Set (GPDS)
To obtain the actual positive set. I've created a tool that automatically obtains the hits against the positive set and writes an FASTA output file. It also does this for all the contaminants to give you the user information about the proteins that were removed. Furthermore, it gives you an overview of the percentage of contaminants.<br/>

See [GPDS](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/blob/main/Scripts/08_GetPositiveDataSet_GPDS/README.md) for a more in-depth overview of what we did.

## 8. BUSCO III
The decontamination step is designed to be strict—favoring the removal of potential contaminants over the risk of keeping false positives. As a result, while it's effective at cleaning up the data, it can also lead to false negatives, where genuine sequences are mistakenly filtered out.
Before we move on to inferring gene families (orthogroups) with OrthoFinder, we want to check how complete the transcriptomes are after decontamination. Some drop in completeness is expected, given how the filtering works. But this step helps us spot any samples that may have lost too much genomic content to be useful going forward.

## 9. OrthoFinder
For the next step, we have to run [OrthoFinder](https://github.com/davidemms/OrthoFinder) ([DM Emms and S Kelly 2019](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-019-1832-y)) to obtain the OrtoGroups. For this we use a guide tree and all the positive samples we have, and included also our outgroups. <br/><br/>
See [OrthoFinder](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/tree/main/Scripts/09_OrthoFinder) for a more in-depth overview of what we did.

## 10. OrthoGroup Sequence Grabber
This is another tool I've created to obtain all the Fasta Blocks (fasta block = fasta header + sequence) for each OrthoGroup and create a Fasta output file. Furthermore, it can take into consideration how many taxonomic groups you want to have as a minimum for each Fasta File as a filter. <br/><br/>
See [OSG](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/blob/main/Scripts/10_OrthogroupSequenceGrabber_OSG) for a more in-depth overview of what we did.

In the pipeline, you will see two different sets as an output for OSG
1. Outgroup Set
2. Ingroup Set

We later combine them (see COGS) to get a good representation of the IN and OUT groups.

### Why two datasets?
From past projects e.g. ([The Klebsormidiohyceae](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae)) we concluded that when using taxonomic group filtering you automatically create a bias for either the ingroup (species of interest) or the outgroup (your reference dataset). This can be seen as low/high branch support for the final phylogenomic trees. By combining the two datasets we (mostly) see a 100% branch support on every (ancestral) node. Hence why we decided to incorporate these two sets

### Outgroup Set
This was the original dataset we used within the preprint (on archive), however after our Reviewer pointed out that the In-Groups (Klebsormidiophyceae) had no great branch support but had great branch support for the out-group.
For this set we used the Taxonomic Group file: [Klebsormidiophyceae_TaxonomicGroupFile_14_Taxa_420_set.txt](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/blob/main/Scripts/10_OrthogroupSequenceGrabber_OSG/TaxonomicGroupFiles/Klebsormidiophyceae_TaxonomicGroupFile_14_Taxa_420_set.txt) and used a threshold value of 10 (10/14 Taxonomic Groups had to be present).

### New Set
We basically started this set to define a good set that represents the In-Groups (Klebsormidiophyceae). Aka, have good branch support for them. For this set, we used the Taxonomic Group file: [Klebsormidiophyceae_TaxonomicGroupFile_4_Taxa.txt](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/blob/main/Scripts/10_OrthogroupSequenceGrabber_OSG/TaxonomicGroupFiles/Klebsormidiophyceae_TaxonomicGroupFile_4_Taxa.txt) and used a threshold value of 3 (3/4 Taxanomic Groups had to be present).


## 11. MIAF
As preparation for [PhyloPyPruner](https://pypi.org/project/phylopypruner/) to remove all the paralogs, we have to align all the sequences (Output from OSG) with [MAFFT](https://mafft.cbrc.jp/alignment/software/) ([K. Katoh and D.M. Standley 2013](https://academic.oup.com/mbe/article/30/4/772/1073398)) and then create trees out of the MSAs with [IQTree](http://www.iqtree.org/) ([Bui Quang Minh *et al* 2020](https://academic.oup.com/mbe/article/37/8/2461/5859215)) <br/>
See [MAFFT/IQTree](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/tree/main/Scripts/11_MAFFT_IQtree) for a more in-depth overview of what we did.
For this step, IQTree2 V2.0.6 was used. <br/><br/>See [IQtree Exectuables](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/tree/main/Executables/IQTree)


## 12. Apply PhyloPyPruner Format
This is the 3rd tool I've created. It basically reformats the Newick tree files that IQtree gives as an output (by default) and makes it in a format that PhyloPyPruner (PPP) can use.<br/><br/>
See [APPPFilter](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/tree/main/Scripts/12_APPPFilter) for a more in-depth overview of what we did.


## 13. PhyloPyPruner
At this step, we remove all the paralogs from the OrtoGroups to get the desired species per OrthoGroup (Fasta file).
For the different sets, we used different parameters, which can be found in the following scripts.
1. Old Set: [PhyloPruner_I_Conda_Gandalf_Tax10.sh](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/blob/main/Scripts/13_Phylopypruner/Scripts/13_Phylopypruner/PhyloPruner_I_Conda_Gandalf_Tax10.sh)
2. New Set: [PhyloPruner_I_Conda_Gandalf_CombinedSetTax21_New1.sh](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/blob/main/Scripts/13_Phylopypruner/Scripts/13_Phylopypruner/PhyloPruner_I_Conda_Gandalf_CombinedSetTax21_New1.sh)

<br/>See [PhyloPyPruner](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/tree/main/Scripts/13_Phylopypruner) for a more in-depth overview of what we did.

<br/>To get more information on PhyloPyPruner please follow the website link https://pypi.org/project/phylopypruner/

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
