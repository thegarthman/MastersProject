library("foreach")
library("doSNOW")
library("randomForest")
cl <- makeCluster(4, type="SOCK",outfire="")
registerDoSNOW(cl)

x <- matrix(runif(500), 100)
y <- gl(2, 50)

rf <- foreach(ntree = rep(250, 4), .combine = combine, 
              .packages = "randomForest") %dopar% {
              randomForest(x,y, ntree = ntree)
  }
rf