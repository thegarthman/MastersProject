## GLM Model ##
library(rpart)

## State as factor ##
## Unweighted##
print("Fitting Unweighted Tree")
tree_uw_state <- rpart(wage ~ 
                   factor(year) + factor(state) + factor(FS) + factor(HHL) + AGEP
                 + factor(ENG) + factor(FOD1P) + factor(SEX) + WKHP + factor(DIS)
                 + factor(INDP) + factor(OCCP) + factor(NATIVITY) + factor(RAC1P),
              data=train,
              na.action=na.omit)

## Weighted ##
# print("Fitting Weighed Tree")
# tree_w_state <- rpart(wage ~ 
#                         factor(year) + factor(state) + factor(FS) + factor(HHL) + AGEP
#                       + factor(ENG) + factor(edu) + factor(SEX) + WKHP + factor(DIS)
#                       + factor(indp) + factor(occp) + factor(NATIVITY) + factor(RAC1P),
#               weights = PWGTP,
#               data=train,
#               na.action=na.omit)


# ## County as factor ##
# print("Fitting Unweighted Tree")
# tree_uw_cty <- rpart(wage ~ 
#                          factor(year) + factor(county) + factor(FS) + factor(HHL) + factor(RESMODE) + AGEP
#                        + factor(COW) + factor(ENG) + factor(SCHL) + factor(SEX) + WKHP + factor(DIS)
#                        + factor(FOD1P) + factor(INDP) + factor(OCCP) + factor(NATIVITY) + factor(RAC1P),
#                        data=train,
#                        na.action=na.omit)
# 
# ## Weighted ##
# print("Fitting Weighed Tree")
# tree_w_cty <- rpart(wage ~ 
#                         factor(year) + factor(county) + factor(FS) + factor(HHL) + factor(RESMODE) + AGEP
#                       + factor(COW) + factor(ENG) + factor(SCHL) + factor(SEX) + WKHP + factor(DIS)
#                       + factor(FOD1P) + factor(INDP) + factor(OCCP) + factor(NATIVITY) + factor(RAC1P),
#                       weights = PWGTP,
#                       data=train,
#                       na.action=na.omit)
# 
# 
# save.image()

