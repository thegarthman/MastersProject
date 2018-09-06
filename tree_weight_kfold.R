
library(plyr)

k = 10 #Folds

combine$kfold <- sample(1:k,nrow(combine),replace = TRUE)
list <- 1:k

prediction <- data.frame()
testsetCopy <- data.frame()

progress.bar <- create_progress_bar("text")
progress.bar$init(k)

for (i in 1:k){
  # remove rows with id i from dataframe to create training set
  # select rows with id i to create test set
  trainingset <- subset(combine, kfold %in% list[-i])
  testset <- subset(combine, kfold %in% c(i))
  
  # running lmodel
  tree_kfold <- tree(welfare~
                   AGEP+factor(DIS)+factor(WKL)+wage+SCHL+year,
                   data = trainingset
                   )
  
  # remove response column 1, Sepal.Length
  temp <- as.data.frame(predict(tree_kfold, testset[,-1]))
  # append this iteration's predictions to the end of the prediction data frame
  prediction <- rbind(prediction, temp)
  
  # append this iteration's test set to the test set copy data frame
  # keep only the Sepal Length Column
  testsetCopy <- rbind(testsetCopy, as.data.frame(testset[,1]))
  
  progress.bar$step()
}

# add predictions and actual Sepal Length values
result <- cbind(prediction, testsetCopy[, 1])
names(result) <- c("Predicted", "Actual")
result$Difference <- abs(result$Actual - result$Predicted)

# As an example use Mean Absolute Error as Evalution 
print(summary(result$Difference))