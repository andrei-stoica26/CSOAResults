# CSOAResults

This repository contains the code used to generate the results from the CSOA 
paper. It is structured as follows:

1. The `generate_seurats.R` file contains the code used to generate the Seurat
objects on which the gene set analysis methods were run.
2. The `gene_sets_blood.R`, `gene_sets_breast.R`, `gene_sets_lung.R` and 
`gene_sets_panc.R` files contain the code used to create gene sets for each 
dataset.
3. The `run_methods.R` file contains the code used to run the gene set analysis
methods on each Seurat object and to save the resulting Seurat objects.
4. The `run_benchmark.R` file contains the code used to run the benchmark
on each Seurat object generated using `run_methods.R` and to save the benchmark
results.
5. The `figures.R` file contains the code used to generate the figures from the
CSOA paper, using input generated with `run_methods.R` and `run_benchmark.R`.

