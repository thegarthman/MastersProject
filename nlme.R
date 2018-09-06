### Basic Linear Mixed Model with Year and Random Effect ###

### Running only with Oregon data ###

library(lme4)

# First look at all states
# # unweighted
# nlme_all_uw <- lme(wage ~ factor(state) + factor(FS) + factor(HHL) + factor(RESMODE) + AGEP
#                 + factor(COW) + factor(ENG) + factor(SCHL) + factor(SEX) + WKHP + factor(DIS)
#                 + factor(FOD1P) + factor(INDP) + factor(NATIVITY) + factor(RAC1P),
#                 random=~year,
#                 na.action=na.omit,
#                 data=train)
# 
# # weighted
# nlme_all_w <- lme(wage ~ factor(state)+ factor(FS) + factor(HHL) + factor(RESMODE) + AGEP
#                 + factor(COW) + factor(ENG) + factor(SCHL) + factor(SEX) + WKHP + factor(DIS)
#                 + factor(FOD1P) + factor(INDP) + factor(NATIVITY) + factor(RAC1P),
#                 random=~year,
#                 weights=PWGTP,
#                 na.action=na.omit,
#                 data=train)


oregon <- train[which(train$state==41),]

# unweighted
nlme_or_uw <- lmer(wage ~ factor(FS) + factor(HHL) + factor(RESMODE) + AGEP + factor(NATIVITY)
                  + factor(COW) + factor(ENG) + factor(SCHL) + factor(SEX) + WKHP + factor(DIS)
                  + factor(FOD1P) + factor(INDP) + factor(OCCP) + factor(RAC1P) + (1|county),
                 na.action=na.omit,
                 data=oregon)

save.image()

# weighted
nlme_or_w <- lmer(wage ~ factor(FS) + factor(HHL) + factor(RESMODE) + AGEP+ factor(NATIVITY)
                 + factor(COW) + factor(ENG) + factor(SCHL) + factor(SEX) + WKHP + factor(DIS)
                 + factor(FOD1P) + factor(INDP) + factor(OCCP) + factor(RAC1P) + (1|county),
                weights=PWGTP,
                na.action=na.omit,
                data=oregon)

save.image()

print(summary(nlme_or_uw))
print(summary(nlme_or_w))

