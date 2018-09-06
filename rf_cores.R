## Random Forest Parallel Processing ##


print("Loading libraries")
library("foreach")
library("doSNOW")
library("randomForest")
print("Libraries loaded")

print("Setting up Cores")
cl <- makeCluster(4,outfile="")
registerDoSNOW(cl)

print("Setting up vectors")

v <- cbind(train$wage,train$year, as.factor(train$state), as.factor(train$FS), as.factor(train$HHL), 
           as.factor(train$RESMODE), train$AGEP, as.factor(train$COW), 
           as.factor(train$ENG), as.factor(train$JWTR), as.factor(train$MAR), 
           as.factor(train$SCHG), train$SCHL, as.factor(train$SEX), 
           train$WKHP, as.factor(train$WKL), as.factor(train$DIS), 
           as.factor(train$FOD1P), as.factor(train$HICOV), as.factor(train$INDP), 
           as.factor(train$NATIVITY), as.factor(train$RAC1P))

v <- na.omit(v)

v <- data.frame(v)

names(v) <- list("wage", "year", "state", "FS", "HHL", 
                 "RESMODE", "AGEP", "COW", 
                 "ENG", "JWTR", "MAR", 
                 "SCHG", "SCHL", "SEX", 
                 "WKHP", "WKL", "DIS", 
                 "FOD1P", "HICOV", "INDP", 
                 "NATIVITY", "RAC1P")

w <- subset(v,select=wage)
v <- subset(v,select=c(-wage))

print("Starting Random Forest Computation")
randfor <- foreach(ntree = rep(250, 4), .combine = combine, .multicombine=TRUE,
      .packages=("randomForest")) %dopar% {
        randomForest(x=v,y=w[,1],
                     ntree = ntree,
                     na.action=na.omit())
         }
randfor 



print("Saving image")
save.image()

print("Done")