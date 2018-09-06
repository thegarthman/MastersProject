#### Fitting and Predicting Regression Trees ####

# Weight = PWGTP

library(rpart)

a <- proc.time()

print("Refitting Regression Tree 1")
treefit_1 <- rpart(wage ~ WKHP + factor(INDP) + factor(FOD1P) + factor(OCCP) 
                   + AGEP + factor(SEX),
                   weights=PWGTP,
                   data=train
                   )

print("Refitting Regression Tree 2")
treefit_2 <- rpart(wage ~ WKHP + factor(INDP) + factor(SCHL) + factor(OCCP) 
                    + AGEP + factor(SEX) + factor(RAC1P),
                    weights=PWGTP,
                    data=train
                    )

print("Starting Predictions on Test Set")
test$treefit1 <- predict(treefit_1,test)
test$treefit2 <- predict(treefit_2,test)


test$treediff1 <- test$wage - test$treefit1
test$treediff2 <- test$wage - test$treefit2

print("Summary statistics for first tree model")
print(summary(abs(test$treediff1)))
print(sum(abs(test$treediff1)^2)/nrow(test))

print("Summary statistics for second tree model")
print(summary(abs(test$treediff2)))
print(sum(abs(test$treediff2)^2)/nrow(test))








print(proc.time() - a)