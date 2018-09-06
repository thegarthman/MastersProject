### Random Forest Test ###

print("Loading libraries")
library("foreach")
library("doSNOW")
library("randomForest")
print("Libraries loaded")

print("Setting up Cores")
cl <- makeCluster(4,type="SOCK",outfile="")
registerDoSNOW(cl)

randfor <- foreach(ntree = rep(100, 4), .combine = combine, .multicombine=TRUE,
                   .packages=("randomForest")) %dopar% {
                    randomForest(wage ~ AGEP + WKHP + FS,
                    data=train,
                    ntree=ntree,
                    na.action=na.omit,
                    norm.votes=FALSE)
                    }
          
randfor