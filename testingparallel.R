library(parallel)
library(doParallel)

cl <- makeCluster(2)
registerDoParallel(cl)
foreach(i=1:3) %dopar% sqrt(i)

registerDoParallel(cores=2)
foreach(i=1:3) %dopar% sqrt(i)

