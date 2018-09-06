#### GAM Testing ####

library(lme4)

model_gam <- gam(
  wage ~ factor(state) + factor(FS) +  s(AGEP,3)
  + factor(ENG) + factor(edu) + factor(SEX) + s(WKHP,3) + factor(DIS)
  + factor(INDP) + factor(OCCP) + factor(NATIVITY) + factor(RAC1P),
#   weights=PWGTP,
  data=train,
  trace=TRUE
)
summary(model_gam)

# png("gam_splines.png",height=2000,width=1000)
# par(mfrow=c(4,3))
# plot(model_gam)
# par(mfrow=c(1,1))
# dev.off()


# model_gam <- gam(
#   wage ~ s(AGEP,2) + s(WKHP,2),
#   data=train,
#   trace=TRUE
# )
# summary(model_gam)
# plot(model_gam)