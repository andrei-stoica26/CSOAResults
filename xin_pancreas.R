#This is a demo (used for package examples, not for results)

alphaMarkers <- c('GCG', 'TTR', 'PCSK2', 'FXYD5', 'LDB2', 'MAFB',
                  'CHGA', 'SCGB2A1', 'GLS', 'FAP', 'DPP4', 'GPR119',
                  'PAX6', 'NEUROD1', 'LOXL4', 'PLCE1', 'GC', 'KLHL41',
                  'FEV', 'PTGER3', 'RFX6', 'SMARCA1', 'PGR', 'IRX1',
                  'UCP2', 'RGS4', 'KCNK16', 'GLP1R', 'ARX', 'POU3F4',
                  'RESP18', 'PYY', 'SLC38A5', 'TM4SF4', 'CRYBA2', 'SH3GL2',
                  'PCSK1', 'PRRG2', 'IRX2', 'ALDH1A1','PEMT', 'SMIM24',
                  'F10', 'SCGN', 'SLC30A8')

betaMarkers <- c('INS', 'IAPP', 'GJD2', 'PDX1', 'SLC2A2', 'NPY', 'MAFA', 'PFKFB2',
                 'HOPX', 'PAX6', 'MAFB', 'CASR', 'EDARADD', 'SCGB2A1', 'TGFBR3',
                 'ADCYAP1', 'SH3GL2', 'NEUROD1','ISL1', 'RGS16', 'SMAD9', 'SIX3',
                 'BMP5', 'PIR', 'STXBP5', 'DLK1', 'MEG3', 'GCGR', 'LMX1A', 'JPH3',
                 'CD40', 'HAMP','EZH1', 'NTRK1','FXYD2', 'RIMS1', 'EFNA5', 'NPTX2',
                 'PAX4', 'PCSK2', 'G6PC2', 'SLC30A8', 'PCSK1', 'SCGN', 'IGF2',
                 'SYT13', 'FFAR2', 'SIX2')

geneSetsDemo <- list(alphaMarkers, betaMarkers)
names(geneSetsDemo) <- c('alpha', 'beta')
