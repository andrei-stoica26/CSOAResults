#This file contains instructions to install all packages currently not on Bioconductor or CRAN

#Install packages
BiocManager::install("andrei-stoica26/CSOA")
BiocManager::install("andrei-stoica26/henna")
BiocManager::install("andrei-stoica26/hammers")
BiocManager::install("andrei-stoica26/GSABenchmark")

#Look at package versions
packageVersion('CSOA')
packageVersion('henna')
packageVersion('hammers')
packageVersion('GSABenchmark')
