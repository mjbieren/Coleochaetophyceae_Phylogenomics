# Quality Control: FastQC & MultiQC

This is the **first step** in the RNA-seq data processing pipeline and involves performing quality control checks on raw sequencing reads using **FastQC**, followed by a combined summary report using **MultiQC**.

---

## FastQC

[FastQC](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/) is used to assess the quality of raw RNA-seq reads.

### Usage

To run FastQC on each subdirectory (one level deep), use the provided script:

👉 [`01_FastQC_Dir.sh`](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/blob/main/Scripts/01_FastQC/01_FastQC_Dir.sh)

Alternatively, you can run FastQC manually within any directory:

```
fastqc *.fq.gz
```

## MultiQC Summary Report

This step of the pipeline summarizes quality control metrics from multiple samples using **MultiQC**. It is typically run **after** FastQC to aggregate all individual quality reports into a single, interactive HTML summary.

---

### 📊 What is MultiQC?

[MultiQC](https://multiqc.info/) parses output files from tools like FastQC, STAR, HISAT2, Salmon, and many others. It creates a single, unified report that makes it easier to compare quality metrics across many samples.

---

### 🛠 Usage

After running FastQC (or other compatible tools), run MultiQC on the directory containing their output:

```bash
multiqc <INPUT_DIRECTORY> -o <OUTPUT_DIRECTORY>
