## 6. BUSCO II

The sixth step involves running BUSCO again, this time on the protein set derived from the TransDecoder output. This step assesses the completeness of the predicted protein sequences, especially since the `--single_best_only` option used in TransDecoder can reduce completeness scores.

This secondary BUSCO run serves as a quality check to ensure that the protein sets remain suitable for downstream analyses.

In our environment, BUSCO was available as a module on the High-Performance Cluster. Alternatively, you can install BUSCO via conda:

```bash
conda create -n busco -c conda-forge -c bioconda busco
