# 15. Combine Orthogroup Sets

**[COGS (Combine OrthoGroup Sets)](https://github.com/mjbieren/COGS)** is a custom tool designed to merge two orthogroup datasets in a phylogenomic workflow. In our study on Klebsormidiophyceae, we encountered a situation where two orthogroup inference runs gave complementary results:

- The **Outgroup Set** included better representation for **outgroup taxa**, but had poor ingroup coverage.
- The **Ingroup Set** offered strong **ingroup coverage**, but missed several key outgroup sequences.

Rather than rerunning the entire pipeline from the OSG step, we used **Method 2** of COGS to merge these two sets in a fast and resource-efficient manner. This method reuses the multiple sequence alignments (MSAs) and gene trees already generated by MIAF, avoiding the need to recompute them.

## Why We Used COGS (Method 2)

- **Orthogroup names** were parsed from the PhyloPyPruner output folders of both sets.
- **Duplicates** were automatically removed.
- The tool then referenced the original PhyloPyPruner input folders to **copy the relevant MSA and tree files** into a new, combined folder.

This provided us with a unified and taxonomically balanced orthogroup dataset — ready for downstream analyses — without requiring additional alignment or gene tree steps.

This approach significantly **reduced computational time and memory usage**, while improving dataset completeness.

👉 For more technical details, source code, and usage instructions, see the [COGS repository](https://github.com/mjbieren/COGS/).

### Method 2
```
COGS_Static.out -s <PPP_INGROUP_OUTPUT> -x <PPP_INGROUP_INPUT> -t <FPPP_OUTGROUP_OUTPUT> -y <PPP_OUTGROUP_INPUT> [-p]
```

For an example script see: [15_COGS.sh](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/blob/main/Scripts/15_COGS/15_COGS.sh)

### Options

| Flag            | Description                                                                                       |
|-----------------|-------------------------------------------------------------------------------------------------|
| `-f <FastaFilesBase>`    | Path to the directory containing your FASTA files. **Required METHOD 1**                               |
| `-s <FastaFileFirstSet>` | Path to the first orthogroup set in FASTA format. **Required**                                |
| `-t <FastaFileSecondSet>`| Path to the second orthogroup set in FASTA format. **Required**                               |
| `-o <OrthoGroupFilesPath>`| Path to the directory containing the Orthogroups in TSV format. **Required METHOD 1**                 |
| `-x <PPPInputDirSet1>`   | Use the PhyloPyPruner input directory for Set 1 instead of the base FASTA file. **REQUIRED METHOD 2**  |
| `-y <PPPInputDirSet2>`   | Use the PhyloPyPruner input directory for Set 2 instead of the base FASTA file. **REQUIRED METHOD 2**  |
| `-r <OutputDirPath>`     | Path to the directory where the output files will be written. **Required**                    |
| `-p`                    | Reformat all FASTA headers to the format needed for PhyloPyPruner. **Optional** (default: keep original headers) |

