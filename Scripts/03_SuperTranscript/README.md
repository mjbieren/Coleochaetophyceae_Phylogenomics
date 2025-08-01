# SuperTranscripts

The third step in the pipeline involves generating SuperTranscripts from the assembled transcriptome. 

[SuperTranscripts](https://github.com/trinityrnaseq/trinityrnaseq/wiki/SuperTranscripts) is a module within the Trinity pipeline that provides a compact representation of all isoforms for each gene, facilitating downstream analyses.

To run SuperTranscripts, you can either modify the provided [03_SuperTranscripts.sh](https://github.com/mjbieren/Coleochaetophyceae_Phylogenomics/blob/main/Scripts/03_SuperTranscript/03_SuperTranscript.sh) script or execute the following command directly:

```bash
$TRINITY_HOME/Analysis/SuperTranscripts/Trinity_gene_splice_modeler.py --trinity_fasta Trinity.fasta
