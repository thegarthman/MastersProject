#### Linear Regression Models with AIC ####

# library(MASS)

lm_uw_edu <- lm(wage ~ factor(year) + factor(state) + factor(FS) + factor(HHL) +  AGEP
                  + factor(COW) + factor(ENG) + factor(edu) + factor(SEX) + WKHP + factor(DIS)
                  + factor(FOD1P) + factor(INDP) + factor(OCCP) + factor(NATIVITY) + factor(RAC1P),
                  na.action=na.omit,
                  data=train)

# weighted
lm_w_edu <- lm(wage ~ factor(year) + factor(state) + factor(FS) + factor(HHL) + AGEP
                 + factor(COW) + factor(ENG) + factor(edu) + factor(SEX) + WKHP + factor(DIS)
                 + factor(FOD1P) + factor(INDP) + factor(OCCP) + factor(NATIVITY) + factor(RAC1P),
                 na.action=na.omit,
                 weights=PWGTP,
                 data=train)

# lm_uw_cty <- lm(wage ~ factor(year) + factor(county) + factor(FS) + factor(HHL) + factor(RESMODE) + AGEP
#                   + factor(COW) + factor(ENG) + factor(SCHL) + factor(SEX) + WKHP + factor(DIS)
#                   + factor(FOD1P) + factor(INDP) + factor(OCCP) + factor(NATIVITY) + factor(RAC1P),
#                   na.action=na.omit,
#                   data=train)
# 
# # weighted
# lm_w_cty <- lm(wage ~ factor(year) + factor(county) + factor(FS) + factor(HHL) + factor(RESMODE) + AGEP
#                  + factor(COW) + factor(ENG) + factor(SCHL) + factor(SEX) + WKHP + factor(DIS)
#                  + factor(FOD1P) + factor(INDP) + factor(OCCP) + factor(NATIVITY) + factor(RAC1P),
#                  na.action=na.omit,
#                  weights=PWGTP,
#                  data=train)

print("End of model fitting")

# save.image()
# 
# print("Starting Stepwise AIC")
# 
# aic_uw_state <- stepAIC(lm_uw_state)
# aic_w_state  <- stepAIC(lm_w_state)
# aic_uw_cty <- stepAIC(lm_uw_cty)
# aic_w_cty  <- stepAIC(lm_w_cty)

print("Done")