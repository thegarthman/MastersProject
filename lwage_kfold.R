#### Cross Validation Excluding People Who do not Work####


library(plyr)
# library(rpart)
k = 10 #Folds

attach(train)
v <- cbind(
  wage , year, state , FS ,  AGEP
  , ENG , edu , SEX , WKHP , DIS
  , INDP , OCCP , NATIVITY , RAC1P,
  PWGTP
)
detach(train)


v <- na.omit(v)

v <- data.frame(v)

names(v) <- list(
  "wage" , "year", "state" , "FS" ,  "AGEP"
  , "ENG" , "edu" , "SEX" , "WKHP" , "DIS"
  , "INDP" , "OCCP"  , "NATIVITY" , "RAC1P",
  "PWGTP"
)

v <- v[v$wage>0,]

v$kfold <- sample(1:k,nrow(v),replace = TRUE)
list <- 1:k

prediction <- data.frame()
testsetCopy <- data.frame()

progress.bar <- create_progress_bar("text")
progress.bar$init(k)

for (i in 1:k){
  # remove rows with id i from dataframe to create training set
  # select rows with id i to create test set
  trainingset <- subset(v, kfold %in% list[-i])
  testset <- subset(v, kfold %in% c(i))
  
  # running lmodel
  lm_kfold <- lm(wage ~ factor(state) + factor(FS) +  AGEP
                 + factor(ENG) + factor(edu) + factor(SEX) + WKHP + factor(DIS)
                 + factor(INDP) + factor(OCCP) + factor(NATIVITY) + factor(RAC1P),
                 weights=PWGTP,
                 na.action=na.omit,
                 data=trainingset)
  
  
  temp <- as.data.frame(predict(lm_kfold, testset[,-1]))
  prediction <- rbind(prediction, temp)
  
  testsetCopy <- rbind(testsetCopy, as.data.frame(testset[,1]))
  
  progress.bar$step()
}

# add predictions and actual Sepal Length values
result <- cbind(prediction, testsetCopy[, 1])
names(result) <- c("Predicted", "Actual")
result$Difference <- abs(result$Actual - result$Predicted)
print(summary(result$Difference))

print(paste0("Mean Square Error is ", sum((result$Difference)^2)/nrow(v)))

rm(k);rm(i);rm(list);rm(prediction);rm(progress.bar);rm(testset);rm(testsetCopy);rm(trainingset);rm(v)
