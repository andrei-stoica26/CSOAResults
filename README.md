# CSOAResults

This repository contains the code used to generate the results from the CSOA 
paper.

## 1 Preparation

It is assumed that all required CRAN and Bioconductor packages have already 
been installed.

### 1.1 Data

The data necessary to reproduce our results is available online:

- [Baron pancreas data (human)](https://bioconductor.org/packages/release/data/experiment/html/scRNAseq.html)
- [Lung proximal airway stromal cells (SRA640325_SRS2769051)](https://panglaodb.se/view_data.php?sra=SRA640325&srs=SRS2769051)
- [Merkel cell carcinoma (SRA749327_SRS3693909)](https://panglaodb.se/view_data.php?sra=SRA749327&srs=SRS3693909)
- [Peripheral blood mononuclear cells (SRA550660_SRS2089639)](https://panglaodb.se/view_data.php?sra=SRA550660&srs=SRS2089639)

### 1.2 Installing Github dependencies

The [installs_nonstandard.R](https://github.com/andrei-stoica26/CSOAResults/blob/main/installs_nonstandard.R) 
file contains the code used to install packages that are currently not 
available on CRAN or Bioconductor.

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
[gene_sets_merkel.R](https://github.com/andrei-stoica26/CSOAResults/blob/main/gene_sets_merkel.R), 
[gene_sets_lung.R](https://github.com/andrei-stoica26/CSOAResults/blob/main/gene_sets_lung.R) 
and [gene_sets_panc.R](https://github.com/andrei-stoica26/CSOAResults/blob/main/gene_sets_panc.R) 
files contain the code used to create gene sets for each dataset.

## 2 Testing the methods

The [run_methods.R](https://github.com/andrei-stoica26/CSOAResults/blob/main/run_methods.R) 
file contains the code used to run the gene set analysis methods on each Seurat 
object and to save the resulting Seurat objects.

The [run_benchmark.R](https://github.com/andrei-stoica26/CSOAResults/blob/main/run_benchmark.R) 
file contains the code used to run the benchmark on each Seurat object and to save 
the benchmark results.

The [run_shuffle.R](https://github.com/andrei-stoica26/CSOAResults/blob/main/run_shuffle.R) 
file contains the code used to run CSOA at different choices of gene loss and noise.

The [run_shuffle_benchmark.R](https://github.com/andrei-stoica26/CSOAResults/blob/main/run_shuffle_benchmark.R) 
file contains the code used to benchmark CSOA runs performed at different choices of gene loss and noise.

## 3 Visualization
The [figures_abstract.R](https://github.com/andrei-stoica26/CSOAResults/blob/main/figures_abstract.R)
file contains the code used to generate the CSOA graphical abstract. 
It sources the [visualization_abstract.R](https://github.com/andrei-stoica26/CSOAResults/blob/main/visualization_abstract.R)
file, which provides plotting functions.

The [figures_results.R](https://github.com/andrei-stoica26/CSOAResults/blob/main/figures_results.R)
file contains the code used to generate the main result figures.
It sources the [visualization_results.R](https://github.com/andrei-stoica26/CSOAResults/blob/main/visualization_results.R)
file, which provides plotting functions.

The [figures_results_gln.R](https://github.com/andrei-stoica26/CSOAResults/blob/main/figures_results_gln.R)
file contains the code used to generate the figures for the gene loss and noise tolerance assessment.


