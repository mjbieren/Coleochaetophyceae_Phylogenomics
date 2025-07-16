# 21. iTOL – Interactive Tree Of Life

After completing all steps of the phylogenomic pipeline, we used **[iTOL](https://itol.embl.de/)** (Interactive Tree Of Life) to visualize and annotate the final phylogenetic trees.

## Purpose

iTOL provides an interactive platform to:
- Upload and explore the final Newick tree.
- Annotate clades based on taxonomic groups, strain information, or gene-specific traits.
- Display and customize branch support values (e.g., aLRT or bootstrap).
- Easily rename taxa
- Export high-resolution tree figures for publication.

## Workflow

1. **Upload Tree**  
   The final tree output (in `.treefile` or `.nwk` format) was uploaded to iTOL via the web interface.

2. **Add Annotations**  
   Metadata and annotations were added using iTOL’s dataset upload system. These included:
   - Bootstrap/aLRT support values
   - Labels for specific nodes or strains

3. **Export Figure**  
   The final, annotated tree was exported in pdf and newick format for use in publications and presentations.

## Notes

- The tree topology was **not altered** in iTOL — it was used strictly for visualization.
- Annotations were either prepared manually or with simple scripts depending on the group size and complexity.
- For more information on formatting iTOL annotation files, see the official guide: [https://itol.embl.de/help.cgi](https://itol.embl.de/help.cgi)

---
