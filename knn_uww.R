### K-th nearest neighbor ###

# ####
# Going to use two different packages
# 1. kknn package
#    This package includes a method that includes weights
# 
# 2. caret package
#    This package includes a formula specifically for
#    k-th nearest neighbour regression (no weights)
# ####

library(kknn)
library(caret)

print("Fitting Caret KNN Regression")
knnreg_caret <- knnreg(wage ~ 
                   year + factor(state) + factor(FS) + factor(HHL)
                 + factor(RESMODE) + AGEP + factor(COW)
                 + factor(ENG) + factor(JWTR) + factor(MAR)
                 + factor(SCHG) + SCHL + factor(SEX) 
                 + WKHP + factor(WKL) + factor(DIS)
                 + factor(FOD1P) + factor(HICOV)
                 + factor(INDP) + factor(NATIVITY)
                 + factor(RAC1P),
                 data=train,
                 na.action=na.omit)

print(summary(knnreg_caret))


## kknn package
print("Fitting KKNN KNN Regression")
kknnreg_kknn_uw <- kknn(wage ~ 
                         year + factor(state) + factor(FS) + factor(HHL)
                       + factor(RESMODE) + AGEP + factor(COW)
                       + factor(ENG) + factor(JWTR) + factor(MAR)
                       + factor(SCHG) + SCHL + factor(SEX) 
                       + WKHP + factor(WKL) + factor(DIS)
                       + factor(FOD1P) + factor(HICOV)
                       + factor(INDP) + factor(NATIVITY)
                       + factor(RAC1P),
                       data=train,
                       na.action=na.omit)

print(summary(kknnreg_kknn_uw))
