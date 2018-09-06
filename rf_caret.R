### Random Forests using CARET Package ###

library(caret)
library(doMC)
registerDoMC(cores = 4)

print("Starting Random Forest Computation")

set.seed(1234)
rf_caret <- train(wage ~ year + factor(state) + factor(FS) + factor(HHL)
                  + factor(RESMODE) + AGEP + factor(COW)
                  + factor(ENG) + factor(JWTR) + factor(MAR)
                  + factor(SCHG) + SCHL + factor(SEX) 
                  + WKHP + factor(WKL) + factor(DIS)
                  + factor(FOD1P) + factor(HICOV)
                  + factor(INDP) + factor(NATIVITY)
                  + factor(RAC1P), 
                  data = train, 
                  method = "parRF",
                  na.action=na.omit,
                  prox=TRUE)

print("Done")