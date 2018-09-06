#### Linear Regression Models ####


oregon <- train[which(train$state==41),]

lm_or_uw <- lm(wage ~ factor(year) + factor(FS) + factor(HHL) + factor(RESMODE) + AGEP
                  + factor(COW) + factor(ENG) + factor(SCHL) + factor(SEX) + WKHP + factor(DIS)
                  + factor(FOD1P) + factor(INDP) + factor(OCCP) + factor(NATIVITY) + factor(RAC1P),
                  na.action=na.omit,
                  data=oregon)

# weighted
lm_or_w <- lm(wage ~ factor(year) + factor(FS) + factor(HHL) + factor(RESMODE) + AGEP
                 + factor(COW) + factor(ENG) + factor(SCHL) + factor(SEX) + WKHP + factor(DIS)
                 + factor(FOD1P) + factor(INDP) + factor(OCCP) + factor(NATIVITY) + factor(RAC1P),
                 na.action=na.omit,
                 weights=PWGTP,
                 data=oregon)

print(summary(lm_or_uw))
print(summary(lm_or_w))
