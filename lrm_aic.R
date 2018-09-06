#### Step AIC for linear models ####

library(MASS)

aic_uw <- stepAIC(lm_uw_state)
aic_w  <- stepAIC(lm_w_state)
save.image()