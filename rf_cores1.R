## Random Forest Parallel Processing ##


print("Loading libraries")

library("foreach")
library("doSNOW")
library("randomForest")

print("Libraries loaded")

print("Setting up Cores")
cl <- makeCluster(4,type="SOCK",outfile="")
registerDoSNOW(cl)

print("Starting Random Forest Computation")

x <- cbind(train$AGEP,train$WKHP,train$FS)
y <- train$wage

randfor <- foreach(i=1:4, ntree = rep(100,4), .combine = combine,
           .packages=("randomForest")) %dopar% {
           set.seed(i)
           randomForest(x, y,
           ntree = ntree)
         }

stopCluster(cl)


print("Done")