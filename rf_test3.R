### Random Forest Test ###

print("Loading libraries")
library("doMC")
library("randomForest")
print("Libraries loaded")

print("Setting up Cores")
registerDoMC(4)

randfor <- foreach(ntree = rep(100, 4), .combine = combine) %dopar% {
             rf <-  randomForest(wage ~ AGEP + WKHP + FS,
                    data=train,
                    ntree=ntree,
                    na.action=na.omit,
                    norm.votes=FALSE)
                    }
          
randfor