alveolarMarkers <- c('SFTPC', 'SLC34A2', 'SFTPA1', 'NKX2-1', 'ETV5', 'LAMP3',
                     'DDX3Y', 'ABCA3', 'NAPSA', 'LPCAT1', 'CD36', 'SFTPD',
                     'SFTA2', 'PGC', 'CXCL2', 'GRK2', 'PPP1R14C', 'CRLF1',
                     'CTNND1', 'PIGR', 'LRG1', 'NRN1', 'IL1B', 'INMT', 'IRX1',
                     'RUNX3', 'SOAT1','ABCD3', 'ADGRF5', 'SFTPB', 'CLDN18',
                     'MUC1', 'CEBPA', 'EGFL6', 'AGER', 'SDC1'
)

basalMarkers <- c('KRT5', 'KRT14', 'ITGA3', 'KRT15', 'LAMB3', 'RAB38',
                  'SLC16A3', 'PLAU', 'MT1X', 'S100A14', 'LAMC2', 'CDH3',
                  'TP63', 'KRT17',	'GAPDHP1', 'SLC25A37', 'ITGB6', 'ITGB4',
                  'MYLK', 'SPHK1', 'ACTG2', 'IRF6', 'RAB13', 'ACADVL', 'HEBP2',
                  'FBXO32', 'MT1E', 'MT2P1', 'SERINC2', 'NNMT', 'PLP2', 'BMP7',
                  'CTNNB1', 'BCL2', 'KRT6B', 'METTL5', 'ANXA11', 'TMEM14A',
                  'BNIP3', 'TYMP', 'DPP7', 'OPTN', 'CAPN1', 'BACE2', 'ITGA2',
                  'ILK', 'PKP3', 'MT1L', 'SRSF4', 'ALKBH7', 'DNPH1', 'KRT23',
                  'GYPC', 'RARRES1', 'DUSP23', 'MMP7'
)

ependymalMarkers <- c('CFAP54', 'FOXJ1', 'RSPH1', 'CCDC153', 'DYNLRB2', 'PIFO',
                      'CFAP44', 'PCP4L1', 'KRT15', 'AK8', 'CRYGN',
                      'TMEM107', 'RIIAD1', 'TMEM212', 'RARRES2',
                      'LRRC23', 'ANGPTL2', 'STOML3', 'PLTP',
                      'EFNB3', 'MYB', 'RFX2', 'ZMYND10', 'TM4SF1', 'CFAP65',
                      'TRIM71', 'SIX3', 'AQP4', 'CELSR2', 'AQP1',
                      'ENKUR', 'FAM216B', 'CATIP', 'DNAH12', 'FAM166B',
                      'IQCG', 'SPEF2', 'MYO16', 'ODF3B', 'PLXNB2', 'TEKT1',
                      'CHEK2', 'CROCC', 'NME9', 'MEIG1', 'HSPA2',
                      'TEKT4', 'AK7', 'S100B'
)

fibroblastMarkers <- c('VIM', 'PDGFRB', 'LUM', 'COL6A2', 'VTN', 'MFAP5',
                       'COL1A2', 'COL1A1', 'SERPINH1', 'POSTN', 'ASPN',
                       'PRRX1', 'COL6A3', 'PDGFRA', 'FAP', 'CELA1', 'LOX',
                       'P4HA1', 'FGR','TNFRSF1B', 'PRKCD', 'ENO3', 'ABI3',
                       'PIP4K2A', 'SERPINB10', 'CTHRC1', 'TBX18', 'COL15A1',
                       'GJB2', 'IL34', 'SLC6A13', 'ITIH5','DPT', 'PENK',
                       'MMP14', 'ANGPTL2', 'EFEMP1', 'SCARA5', 'IGFBP3',
                       'DPEP1', 'ADAMTS5', 'COL5A1', 'CD248', 'PI16', 'PAMR1',
                       'TNXB', 'MMP2', 'COL14A1', 'CLEC3B', 'IGFBP6', 'COL5A2',
                       'FBN1', 'FKBP10', 'PALLD', 'WIF1', 'SNHG18', 'CDH11',
                       'PTCH1', 'ARAP1', 'FBLN2', 'IGF1', 'FKBP7', 'OAF',
                       'CTSK', 'DKK1', 'C1S', 'RARRES2', 'GREM1', 'SPON2',
                       'TCF21', 'PCSK6', 'COL8A1', 'ENTPD2', 'CXCL8', 'CXCL3',
                       'IL6', 'CYP1B1', 'COL13A1', 'ADAMTS10', 'CCL11',
                       'ADAM33', 'COL4A3', 'COL4A4', 'LAMA2', 'ACKR3', 'CD55',
                       'FBLN7', 'FIBIN', 'THBS2', 'NOV', 'PTX3', 'MMP3',
                       'LRRK1', 'HGF', 'FRZB', 'COL12A1', 'COL7A1', 'MEOX1',
                       'PRG4', 'PKD2', 'CCL19', 'NNMT', 'FOXF1', 'HAS1',
                       'CTGF', 'ERCC1', 'WISP1', 'TWIST2', 'RIPK3', 'DDR2',
                       'ELN', 'FN1', 'HHIP', 'FMO2', 'COL3A1', 'FSTL1', 'GSN',
                       'SPARC', 'S100A4', 'NT5E', 'MGP', 'NOX4', 'THY1',
                       'CD40', 'CD44', 'EN1', 'DCN', 'CEBPB', 'EGR1', 'FOSL2',
                       'HIF1A', 'KLF2', 'KLF4', 'KLF6', 'KLF9', 'NFAT5',
                       'NFKB1', 'NR4A1', 'NR4A2', 'PBX1', 'RUNX1', 'STAT3',
                       'TCF4', 'ZEB2', 'LAMC1', 'MEDAG', 'LAMB1', 'DKK3',
                       'TBX20', 'MDK', 'GSTM5', 'NGF', 'VEGFA', 'FGF2',
                       'P4HTM', 'CKAP4', 'INMT', 'CXCL14', 'IL1R1', 'FLI1',
                       'FABP4', 'COPZ2', 'FOSB', 'NFATC1')

luminarMarkers <- c('KRT18', 'MUC1', 'CEBPD', 'KRT8', 'CD9', 'AQP3', 'PIP',
                    'ATP7B', 'HIF1A', 'FGFR4', 'DDR1', 'PGR', 'PTH1R',
                    'AR', 'SERPINA1', 'ATP2C2', 'WNT5A', 'SLC12A2', 'ESR1',
                    'AQP5', 'RUNX1', 'CDH1', 'ANPEP', 'SERPINB4',
                    'FGG', 'SLPI', 'PROM1', 'KRT19', 'SYTL2',
                    'CD74', 'AGR2', 'LTF', 'SAA2', 'KRT23', 'FGFR2',
                    'SERPINB3', 'WFDC2', 'LCN2', 'BTG1', 'CLDN4', 'ANXA1',
                    'HMGA1', 'STC2', 'AREG', 'TNFSF10'
)

smoothMuscleMarkers <- c('ACTA2', 'MYL9', 'RGS5', 'MYLK', 'HHIP', 'MYH11',
                         'GJA4', 'NOX4', 'SH3BGR', 'KCNMB1', 'ITGA9', 'JPH2',
                         'MRVI1', 'KIF1C', 'KCNAB1', 'SEC24D', 'SMOC1',
                         'PDGFD', 'VASN', 'FAS', 'OTUD1', 'SSPN', 'WWP2',
                         'ZBTB44', 'GJC1', 'NRP2', 'PLN', 'SNCG', 'PCP4L1',
                         'BGN', 'SMTN', 'OGN', 'ACKR3', 'NOV', 'LAMB2',
                         'SPON2', 'MFAP5', 'TCF21', 'ITGA8',
                         'RASL12', 'DMPK', 'LOX', 'LMO7', 'PDE4DIP', 'OBSCN',
                         'ANKRD1', 'ACTC1', 'FABP4', 'ANGPT1', 'NF2',
                         'FBLN5', 'FHL2', 'DES', 'RPRM', 'NOTCH3',
                         'WFDC1', 'TAGLN', 'HEXIM1', 'CNN1', 'SPEG', 'MSRB3',
                         'LGR6', 'KAT2B', 'SLC38A11', 'MAP3K7CL', 'RBPMS2',
                         'EHD2', 'AKT2', 'ITGA1', 'LMOD1', 'RRAD', 'HSPB6',
                         'SOD3', 'ACTG2', 'NEXN', 'MYLK4', 'AOC3',
                         'AAED1'
)

geneSetsLung <- list(alveolarMarkers, basalMarkers, ependymalMarkers,
                 fibroblastMarkers, luminarMarkers, smoothMuscleMarkers)
names(geneSetsLung) <- c('PulmonaryAlveolarIICells',
                         'BasalCells',
                         'EpendymalCells',
                         'Fibroblasts',
                         'LuminalEpithelialCells',
                         'SmoothMuscleCells')
qsave(geneSetsLung, 'geneSetsLung.qs')
