source('load_all.R')

runMethods()
benchmark()
runShuffle()
shuffleBenchmark()

smr <- qs_read('smrLung.qs2')
smr$global
