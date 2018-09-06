#### Parallel Random Forests Caret Package ####

x <- data.frame(train$AGEP, train$WKHP, train$FS)
y <- train$wage

library("randomForest")
library("caret")

mtryGrid <- expand.grid(mtry = 5)

parrf_test <- train(x, y, 
                    method="parRF", 
                    ntree=500,
                    tuneGrid=mtryGrid,
                    importance=TRUE)