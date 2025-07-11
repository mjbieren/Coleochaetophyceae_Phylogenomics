# 7. Decontamination

To ensure our dataset is free from contaminant sequences, we performed a decontamination step using [MMseqs2](https://github.com/soedinglab/MMseqs2), a high-performance sequence search and clustering tool.

---

## MMseqs2

[MMseqs2](https://github.com/soedinglab/MMseqs2) (Many-against-Many sequence searching) is a fast and efficient alternative to BLAST, offering speed improvements ranging from 100x to 10,000x. Given that our decontamination step involves comparing against large datasets (RefSeq Archaeal, Bacterial, Fungal, Viral, Plastid, etc.), MMseqs2 provides the performance necessary without significantly sacrificing sensitivity.

We recommend installing MMseqs2 directly from the [official GitHub repository](https://github.com/soedinglab/MMseqs2).

---

## Decontamination Database

On **11 July 2023**, we compiled a comprehensive decontamination database that includes:

- RefSeq: Bacteria, Archaea, Fungi, Viruses
- Plastid, Plasmid, Protozoa, Mitochondrial, and Invertebrate genomes
- **Positive control set**: *Coleochaetophyceae* (strain SAG 110.80Mneu)

To simplify header parsing during classification, we reformatted all FASTA headers using the script [`simplify_headers_for_blastdb.py`](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/blob/main/Scripts/07_Decontamination/simplify_headers_for_blastdb.py), developed by Dr. Iker Irrisari:

```bash
python simplify_headers_for_blastdb.py [inputFile] [RenameHeaders] >> [FileOutput]

```
where the FileOutput is the concatenated file for all sub-databases (e.g., RefSeq Bacteria, RefSeq Archeae, etc).
I used the following combinations:
```
"arch_neg" for the Archea set
"bact_neg" for the Bacteria set
"virus_neg" for the Viridae set
"fungi_neg" for the Fungi set
"invert_neg" for the Invertebrate set
"plast_neg" for the Plastid set
"plasm_neg" for the Plasmid set
"mito_neg" for the Mitochondrion set
"proto_neg" for the Protozoa set
"coleo_pos" for the Coleochaetophyceae positive set (SAG 110.80Mneu in this case as we don't have a reference genome and this is the only axenic strain)
```
These tags are critical for identifying contaminants in later classification steps. Ensure all identifiers are consistent and free of whitespace.

###Preparing the Decontamination Database
To convert the formatted FASTA file into an MMseqs2-compatible database, run:
```
mmseqs createdb Decontamination_Coleo_DB.fa Decontamination_Coleo_DB.db
mmseqs createindex Decontamination_Coleo_DB.db tmp
```
This prepares the decontamination database for alignment and filtering.

## Converting the Protein File.
Next, convert your protein sequences (e.g., from TransDecoder) into an MMseqs2 database:
```
mmseqs createdb StrainName_genes_supertranscript.fasta.transdecoder.pep StrainName_db.db || module purge && exit -1
mmseqs createindex StrainName_db.db tmp || module purge && exit -1
```
Alternatively, you can use the provided script ConvertToMMseqsDatabase.sh in the same directory as your .pep file.


## Running the script
Now simply run the script [Decontamination_MMSEQS_Memmode.sh](https://github.com/mjbieren/Phylogenomics_klebsormidiophyceae/blob/main/Scripts/07_Decontamination/Decontamination_MMSEQS_Memmode.sh)
Don't forget to change the variables on lines: 8,9,10,11.

The output will be a simple outfmt6 output, identical to a blast output file with outfmt6 format.
