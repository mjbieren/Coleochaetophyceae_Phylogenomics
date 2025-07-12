# 12. Apply PhyloPyPruner Format (APPPFormat)

PhyloPyPruner (PPP) requires both alignment and tree files to follow a specific naming format. While OSG (Orthogroup Sequence Grabber) correctly applies this format to alignment files, IQ-TREE removes it from the resulting tree files. The **Apply PhyloPyPruner Format (APPPFormat)** tool is designed to restore this format, ensuring that all inputs are compatible with PPP.

## What It Does

- Reformats `.treefile` outputs from IQ-TREE by replacing underscores (`_`) with at-symbols (`@`) in species/strain names, based on a user-provided taxonomic group file.
- Moves reformatted tree files to a specified output directory.
- Optionally copies `.mafft` alignment files into the same output directory and converts them to `.fa`.

### Requirements

- A **taxonomic group file**, which maps headers to strain/species identifiers.  
  → See [TaxonomicGroupFiles](https://github.com/mjbieren/ApplyPPPFormat/tree/main/TaxonomicGroupFiles) for examples.

## How to Use

1. Edit [`APPPFormat.sh`](https://github.com/mjbieren/ApplyPPPFormat/blob/main/APPPFormat.sh) and configure lines 3–7 with the correct paths.
2. Run the script. The tool is optimized for lightweight use:
   - Requires only **1 CPU**
   - Uses **<1 GB RAM**
   - Can be run on any 64-bit Linux machine (front-end/head node)

Note: The tool is I/O-bound, so speed will depend heavily on disk or network performance rather than processing power.

## Download Precompiled Binaries

Precompiled static binaries are available for common platforms:

- [Debian 12: `APPPFormat_Static_Debian.out`](https://github.com/mjbieren/ApplyPPPFormat/blob/main/Sources/Executables/APPPFormat_Static_Debian.out)
- [Rocky Linux / HPC (Red Hat-based): `APPPFormat_Static_HPC.out`](https://github.com/mjbieren/ApplyPPPFormat/blob/main/Sources/Executables/APPPFormat_Static_HPC.out)

## Compile from Source

Alternatively, you can compile your own binary using the C++ [source files](https://github.com/mjbieren/ApplyPPPFormat/tree/main/Sources/main).  
The tool is built using:

- **Boost 1.88**
- **GCC** (for Linux)
- **Visual Studio 2019** (for Windows/remote dev)

## Command Line Options

```
APPPFormat.out -i [PathToTrees] -t [TreeFileExtension] -r [OutputFolderPath] -g [TaxonomicGroupFilePath] -m [MafftFilesPath:NOT REQUIRED]
```
