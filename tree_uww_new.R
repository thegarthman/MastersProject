## GLM Model ##
library(rpart)

## State as factor ##
## Unweighted##
print("Fitting Unweighted Tree")
tree_w     <- rpart(wage ~ 
                   factor(year) + factor(state) + factor(FS) + AGEP
                 + factor(ENG) + factor(SCHL) + factor(SEX) + WKHP + factor(DIS)
                 + factor(INDP) + factor(OCCP) + factor(NATIVITY) + factor(RAC1P)
                 + AGEP*WKHP + SEX*AGEP + SEX*factor(RAC1P),
              data=train,
              weights=PWGTP,
              na.action=na.omit)

summary(tree_w)


