## GLM Model ##
library(MASS)

## Unweighted##
print("Fitting Unweighted Model")
glm_uw <- glm(wage ~ 
              year + factor(state) + factor(FS) + factor(HHL)
              + factor(RESMODE) + AGEP + factor(COW)
              + factor(ENG) + factor(JWTR) + factor(MAR)
              + factor(SCHG) + SCHL + factor(SEX) 
              + WKHP + factor(WKL) + factor(DIS)
              + factor(FOD1P) + factor(HICOV)
              + factor(INDP) + factor(NATIVITY)
              + factor(RAC1P),
              data=train,
              na.action=na.omit)

print(summary(glm_uw))

# print("Doing Stepwise mode selection for unweighed model")
# step_uw <- stepAIC(glm_uw)


## Weighted ##
print("Fitting Weighed Model")
glm_w <- glm(wage ~ 
                year + factor(state) + factor(FS) + factor(HHL)
              + factor(RESMODE) + AGEP + factor(COW)
              + factor(ENG) + factor(JWTR) + factor(MAR)
              + factor(SCHG) + SCHL + factor(SEX) 
              + WKHP + factor(WKL) + factor(DIS)
              + factor(FOD1P) + factor(HICOV)
              + factor(INDP) + factor(NATIVITY)
              + factor(RAC1P),
              weights = PWGTP,
              data=train,
              na.action=na.omit)

print(summary(glm_w))

# print("Doing Stepwise mode selection for weighed model")
# step_uw <- stepAIC(glm_w)


