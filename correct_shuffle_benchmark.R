newRows <- c('CSOA', 'CSOA_20_20', 'CSOA_20_50', 'CSOA_20_80',
             'CSOA_50_20', 'CSOA_50_50', 'CSOA_50_80',
             'CSOA_80_20', 'CSOA_80_50', 'CSOA_80_80')

correctSummary <- function(smr, newRows){
    for (smrType in c('boundary', 'MCC', 'global', 'efficiency'))
        for (j in seq(length(smr[[smrType]]))){
            smr[[smrType]][[j]] <- smr[[smrType]][[j]][newRows, ]
            smr[[smrType]][[j]] <- smr[[smrType]][[j]][order(smr[[smrType]][[j]]$avg,
                                                             decreasing=TRUE), ]
        }
    for (i in seq(length(smr$predictions)))
        smr$predictions[[i]] <- smr$predictions[[i]][, newRows]
    return(smr)
}
