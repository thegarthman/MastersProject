#### Fitting and Predicting Regression Trees ####

# Weight = PWGTP

library(gam)

a <- proc.time()

print("Refitting GAM 1")
gam_1 <- gam(
  wage ~ factor(state) + factor(FS) +  s(AGEP,3)
  + factor(ENG) + factor(edu) + factor(SEX) + s(WKHP,3) + factor(DIS)
  + factor(INDP) + factor(OCCP) + factor(NATIVITY) + factor(RAC1P),
  weights=PWGTP,
  data=train,
  trace=TRUE
)

print("Refitting GAM 2")

gam_2 <- gam(
  wage ~ s(year,3) + factor(state) + factor(FS) +  s(AGEP,3)
  + factor(ENG) + factor(edu) + factor(SEX) + s(WKHP,3) + factor(DIS)
  + factor(INDP) + factor(OCCP) + factor(NATIVITY) + factor(RAC1P),
  weights=PWGTP,
  data=train,
  trace=TRUE
)


print("Starting Predictions on Test Set")
test$gamfit1 <- predict(gam_1,test)
test$gamfit2 <- predict(gam_2,test)


test$gamdiff1 <- test$wage - test$gamfit1
test$gamdiff2 <- test$wage - test$gamfit2

print("Summary statistics for first GAM")
print(summary(abs(test$gamdiff1)))
print(sum(abs(test$gamdiff1)^2)/nrow(test))

print("Summary statistics for second GAM")
print(summary(abs(test$gamdiff2)))
print(sum(abs(test$gamdiff2)^2)/nrow(test))








print(proc.time() - a)