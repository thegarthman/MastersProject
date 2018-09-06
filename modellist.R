#### List of Models ####

### Linear models by stepwise AIC (maybe add state)
#
lm_or_uw <- lm(wage ~ factor(FS) + factor(RESMODE) + AGEP
               + factor(COW) + factor(ENG) + factor(SCHL) + factor(SEX) + WKHP + factor(DIS)
               + factor(FOD1P) + factor(INDP) + factor(OCCP) + factor(NATIVITY) + factor(RAC1P),
               na.action=na.omit,
               data=oregon)
# dropped year and HHL

# weighted
lm_or_w <- lm(wage ~ factor(FS) + factor(HHL) + factor(RESMODE) + AGEP
              + factor(COW) + factor(ENG) + factor(SCHL) + factor(SEX) + WKHP + factor(DIS)
              + factor(FOD1P) + factor(INDP) + factor(OCCP) + factor(RAC1P),
              na.action=na.omit,
              weights=PWGTP,
              data=oregon)

#dropped nativity and year

### Model from LASSO on oregon

# in order of importance:
#   WKHP, FOD1P, SCHL, SEX, FS, COW, AGEP, COW, OCCP, DIS, INDP, year, NATIVITY, RESMODE,
#   ENG, HHL, RAC1P


### model from lasso on all data normalized

# in order of importance:
#   WKHP, FOD1P, SCHL, SEC, AGEP, OCCP, COW, FS, ENG, state, year, DIS, INDP, RAC1P,
#   NATIVITY, RESMODE, HHL


### model from lasso on all data not normalized ###

# in order of importance:
#   WKHP, FOD1P, OCCP, AGEP, SCHL, INDP, COW, INDP, INDP, year, RAC1P, SEX, ENG, state,
#   FS, HHL, DIS, RESMODE, NATIVITY


#######
### Tree fits on oregon data

# unweighted
# variable importance:
#   WKHP(39), INDP(16), COW(15), FOD1P(11), AGEP(7), OCCP(6), SCHL(6)
# 
# weighted
# variable importance:
#   WKHP(39), INDP(16), COW(14), FOD1P(10), OCCP(7), SCHL(6), AGEP(6), SEX(3)


## Tree fits on all train data

# unweighted
# variable importance:
#   WKHP(33), COW(16), INDP(15), FOD1P(10), SCHL(8), AGEP(7), OCCP(7), SEX(4)
# 
# weighted
# variable importance:
#   WKHP(31), COW(16), INDP(16), FOD1P(10), SCHL(9), OCCP(7), AGEP(7), SEX(4)



