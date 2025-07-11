# TransDecoder

The fifth step in our pipeline is to predict protein sequences from the SuperTranscripts, as these proteins will be used for comparative analyses with OrthoFinder.

In our workflow, TransDecoder was pre-installed on our High-Performance Computing (HPC) cluster, enabling direct usage without additional installation. However, you can easily install it locally using Conda:

```
conda create -n transdecoder -c conda-forge -c bioconda transdecoder
```

## Extracting Long Open Reading Frames with TransDecoder

The first step in the TransDecoder workflow is to identify and extract long open reading frames (ORFs) from the assembled transcripts. This is achieved by running `TransDecoder.LongOrfs`, which generates candidate protein-coding regions for further analysis.
This step is critical for accurately predicting coding sequences and serves as the foundation for downstream homology searches and coding region refinement.

```
TransDecoder.LongOrfs -t <SUPERTRANSCRIPT_FILE_PATH> --output_dir <OUTPUT_DIR>
```

## Predicting Coding Regions with TransDecoder

This step runs `TransDecoder.Predict` to identify the most likely coding regions within the transcript sequences.
The `--single_best_only` option ensures that for each transcript, only the single best coding region prediction is retained. This helps to reduce redundancy by filtering out multiple overlapping or less confident predictions, resulting in a cleaner, more accurate set of protein-coding sequences for downstream analysis.

```
TransDecoder.Predict -t <SUPERTRANSCRIPT_FILE_PATH> --output_dir <OUTPUT_DIR> --single_best_only
```

### Blast Searches
Since this dataset lacks a reference genome, we were unable to incorporate BLASTP homology searches during this step. However, you can refer to [TRANSDECODER](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/edit/main/Scripts/05_Transdecoder/) for an example of how to include BLASTP searches in the workflow.
