#### Fitting and Predicting Regression Trees ####

# Weight = PWGTP

library(lme4)

a <- proc.time()

print("Refitting Mixed Effects Model 1")
lme_1 <- lme(
  wage ~ (1 | PUMA10_final) + factor(year) + factor(FS) +  AGEP
  + factor(ENG) + factor(SCHL) + factor(SEX) + WKHP + factor(DIS)
  + factor(INDP) + factor(OCCP) + factor(NATIVITY) + factor(RAC1P),
  weights=PWGTP,
  data=train,
  trace=TRUE
)

print("Refitting Mixed Effects Model 2")

lme_2 <- lme(
  wage ~ (1 | PUMA10_final) + (1 | year) + factor(FS) +  AGEP
  + factor(ENG) + factor(SCHL) + factor(SEX) + WKHP + factor(DIS)
  + factor(INDP) + factor(OCCP) + factor(NATIVITY) + factor(RAC1P),
  weights=PWGTP,
  data=train,
  trace=TRUE
)


print("Starting Predictions on Test Set")
test$lmefit1 <- predict(lme_1,test)
test$lmefit2 <- predict(lme_2,test)


test$lmediff1 <- test$wage - test$lmefit1
test$lmediff2 <- test$wage - test$lmefit2

print("Summary statistics for first GAM")
print(summary(abs(test$lmediff1)))
print(sum(abs(test$lmediff1)^2)/nrow(test))

print("Summary statistics for second GAM")
print(summary(abs(test$lmediff2)))
print(sum(abs(test$lmediff2)^2)/nrow(test))








print(proc.time() - a)