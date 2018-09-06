### Random Forest Test ###

library(randomForest)

fit <- randomForest(wage ~ AGEP + WKHP + FS,
                    data=train,
                    importance=TRUE,
                    ntree=100)

summary(fit)