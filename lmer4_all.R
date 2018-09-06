### Basic Linear Mixed Model with Year and Random Effect ###

### Running with all data ###

library(lme4)

lmer_test <- lmer(
  wage ~ AGEP + factor(SCHL) + WKHP + factor(INDP) + factor(OCCP)
  + (1 | year),
  data=train
  )

# print("Fitting first model")
# lmer_all <- lmer(
#   wage ~  factor(state) + factor(FS) +  AGEP
#    + factor(ENG) + factor(edu) + factor(SEX) + WKHP + factor(DIS)
#    + factor(indp) + factor(occp) + factor(NATIVITY) + factor(RAC1P)
#    + (1 | year),
#    data=train,
#   )
# 
# print("Fitting second model")
# lmer_all_1 <- lmer(
#   wage ~ factor(year) + factor(FS) +  AGEP
#   + factor(ENG) + factor(edu) + factor(SEX) + WKHP + factor(DIS)
#   + factor(indp) + factor(occp) + factor(NATIVITY) + factor(RAC1P)
#   + (1 | state),
#   data=train,
# )
# 
# print("Fitting third model")
# lmer_all_2 <- lmer(
#   wage ~ factor(year) + factor(FS) +  AGEP
#   + factor(ENG) + factor(edu) + factor(SEX) + WKHP + factor(DIS)
#   + factor(indp) + factor(occp) + factor(NATIVITY) + factor(RAC1P)
#   + (1 | PUMA10_final),
#   data=train,
# )
# 
# print("Fitting fourth model")
# lmer_all_3 <- lmer(
#   wage ~  factor(year) + factor(FS) +  AGEP
#   + factor(ENG) + factor(edu) + factor(SEX) + WKHP + factor(DIS)
#   + factor(indp) + factor(occp) + factor(NATIVITY) + factor(RAC1P)
#   + (PUMA10_final | state),
#   data=train,
# )

