# CSOAResults

This repository contains the code used to generate the results from the CSOA 
paper.

## 1 Preparation

It is assumed that all CRAN and Bioconductor dependencies have already been 
installed.

### 1.1 Data

The data necessary to reproduce our results is available online:

- [Baron pancreas data (human)](https://bioconductor.org/packages/release/data/experiment/html/scRNAseq.html);
- [Lung proximal airway stromal cells (SRA640325_SRS2769051)](https://www.panglaodb.se/view_data.php?sra=SRA640325&srs=SRS2769051);
- [Breast cancer cell line (SRA704181_SRS3305832)](https://www.panglaodb.se/view_data.php?sra=SRA704181&srs=SRS3305832);
- [Peripheral blood mononuclear cells (SRA550660_SRS2089639)](https://www.panglaodb.se/view_data.php?sra=SRA550660&srs=SRS2089639).

### 1.2 Installing Github dependencies

The [installs_nonstandard.R](https://github.com/andrei-stoica26/CSOAResults/blob/main/installs_nonstandard.R) file contains the code used to install packages that are currently not available on CRAN or Bioconductor.

### 1.3 Loading packages and source files

The [main.R](https://github.com/andrei-stoica26/CSOAResults/blob/main/main.R) 
file loads all the required packages and sources
the [tools.R](https://github.com/andrei-stoica26/CSOAResults/blob/main/tools.R) 
file, which provides some helper functions.

### 1.4 Generating Seurat objects and gene sets

The [generate_seurats.R](https://github.com/andrei-stoica26/CSOAResults/blob/main/generate_seurats.R) 
file contains the code used to generate the Seurat objects on which the gene 
set analysis methods were run.

The [gene_sets_blood.R](https://github.com/andrei-stoica26/CSOAResults/blob/main/gene_sets_blood.R), 
[gene_sets_breast.R](https://github.com/andrei-stoica26/CSOAResults/blob/main/gene_sets_breast.R), [gene_sets_lung.R](https://github.com/andrei-stoica26/CSOAResults/blob/main/gene_sets_lung.R) 
and [gene_sets_panc.R](https://github.com/andrei-stoica26/CSOAResults/blob/main/gene_sets_panc.R) 
files contain the code used to create gene sets for each dataset.

## 2 Testing the methods

The [run_methods.R](https://github.com/andrei-stoica26/CSOAResults/blob/main/run_methods.R) 
file contains the code used to run the gene set analysis methods on each Seurat 
object and to save the resulting Seurat objects.

The [run_benchmark.R](https://github.com/andrei-stoica26/CSOAResults/blob/main/run_benchmark.R) 
contains the code used to run the benchmark on each Seurat object and to save 
the benchmark results.

## 3 Visualization
The [figures.R](https://github.com/andrei-stoica26/CSOAResults/blob/main/figures.R)
file contains the code used to generate the figures from the CSOA paper. It
source the [visualization.R](https://github.com/andrei-stoica26/CSOAResults/blob/main/visualization.R)
file, which provides plotting functions.

