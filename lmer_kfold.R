#### Mixed Effect Model K-Fold Validation ####

#### Rescaling Continuous Variables for K-Fold Cross Validation ####

# center then divide by 2 sds.
# suggested by Gelman 
# Andrew Gelman. (2008). “Scaling regression inputs by dividing by two standard deviations”. 
# Statistics in Medicine 27: 2865--2873. http://www.stat.columbia.edu/~gelman/research/published/standardizing7.pdf

train$wage_r <- (train$wage - mean(train$wage))/(2*sd(train$wage))
train$WKHP_r <- (train$WKHP - mean(train$WKHP))/(2*sd(train$WKHP))

print("Weighted K-Fold with Rescaled Variables")

library(plyr)
library(lme4)
k = 10 #Folds

attach(train)
v <- cbind(
  wage_r , PUMA10_final, year, FS ,  AGEP
  , ENG , SCHL , SEX , WKHP_r , DIS
  , INDP , OCCP , NATIVITY , RAC1P, PWGTP
)
detach(train)


v <- na.omit(v)

v <- data.frame(v)

names(v) <- list(
  "wage" , "PUMA10_final", "year", "FS" ,  "AGEP"
  , "ENG" , "SCHL" , "SEX" , "WKHP" , "DIS"
  , "INDP" , "OCCP"  , "NATIVITY" , "RAC1P", "PWGTP"
)

v$kfold <- sample(1:k,nrow(v),replace = TRUE)
list <- 1:k

prediction <- data.frame()
testsetCopy <- data.frame()

progress.bar <- create_progress_bar("text")
progress.bar$init(k)

a <- proc.time()

for (i in 1:k){
  # remove rows with id i from dataframe to create training set
  # select rows with id i to create test set
  trainingset <- data.frame(subset(v, kfold %in% list[-i]))
  testset     <- data.frame(subset(v, kfold %in% c(i)))
  
  # running lmodel
  lm_kfold <- lmer(wage ~ (1 | PUMA10_final) + factor(year) + factor(FS) +  AGEP
                    + factor(ENG) + factor(SCHL) + factor(SEX) + WKHP + factor(DIS)
                    + factor(INDP) + factor(OCCP) + factor(NATIVITY) + factor(RAC1P),
                 weights=PWGTP,
                 data=trainingset
                 )
  
  
  temp <- as.data.frame(predict(lm_kfold, testset[,-1],re.form=NULL,allow.new.levels = TRUE))
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

print(proc.time() - a)
rm(a)

rm(k);rm(i);rm(list);rm(prediction);rm(progress.bar);rm(testset);rm(testsetCopy);rm(trainingset);rm(v)
