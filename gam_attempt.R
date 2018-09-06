#### Generalized Additive Models Attempt ####

library(gam)

gam_model_uw <- gam(wage ~ year + AGEP + WKHP,
                    family=normal,
                    data=train,
                    trance=TRUE)

gam_model_w <- gam(wage ~ year + AGEP + WKHP,
                  data=train,
                  family=normal,
                  trance=TRUE,
                  weights=PWGTP)
