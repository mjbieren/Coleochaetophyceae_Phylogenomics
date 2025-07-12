# 8. BUSCO III – Post-Decontamination Completeness Assessment
The eighth step involves a third BUSCO run, this time on the decontaminated transcriptome assemblies. This step assesses the completeness of the data following the stringent decontamination process, which prioritizes the removal of potential contaminants, even at the risk of introducing false negatives.

Given the nature of this filtering, a drop in BUSCO completeness scores is expected. However, this run serves as a critical quality control checkpoint before proceeding to gene family (orthogroup) inference with OrthoFinder. It allows us to identify transcriptomes that may have lost a significant portion of genuine content during decontamination and may no longer be suitable for downstream comparative analyses.

In our setup, BUSCO was available as a module on the High-Performance Cluster. Alternatively, it can be installed via conda:
```
conda create -n busco -c conda-forge -c bioconda busco
```

Included is the script [08_BUSCO_III_OutputDecontamination.sh](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/blob/main/Scripts/08_BUSCO_III/08_BUSCO_III_OutputDecontamination.sh) that takes the output folder (containing all the positive sets of the sample from step 7) and runs BUSCO on all of them.
