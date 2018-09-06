### Survey GLM with Repeated Replicates ###

library(survey)

train_design <- svrepdesign(
                      weights = ~PWGTP,
                      repweights = "PWGTP[1-80]",
                      type="BRR",
                      data=train,
                      combined.weights=TRUE
  )

glmbrr <- svyglm(wage ~ 
                   factor(SEX) 
                 + WKHP
                 + factor(RAC1P),
                 data=train,
                 design=train_design
  )