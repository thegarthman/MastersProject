#### Random Linear Models ####

random_lm1 <- lm(wage ~ factor(state) + factor(FS) +  AGEP
                  + factor(ENG) + factor(edu) + factor(SEX) + WKHP + factor(DIS)
                  + factor(indp) + factor(occp) + factor(NATIVITY) + factor(RAC1P),
                  na.action=na.omit,
                  data=train)

random_lm2 <- lm(wage ~ factor(state) + factor(FS) +  AGEP
                 + factor(ENG) + factor(FOD1P) + factor(SEX) + WKHP + factor(DIS)
                 + factor(indp) + factor(occp) + factor(NATIVITY) + factor(RAC1P),
                 na.action=na.omit,
                 data=train)

print(AIC(random_lm1))
print(AIC(random_lm2))