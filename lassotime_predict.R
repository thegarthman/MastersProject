## LASSO Implementation ##

library("lars")

print("Building Data Set")

attach(train)
v <- cbind(wage, as.factor(year) , as.factor(FS) , as.factor(HHL) , AGEP
           , as.factor(ENG) , as.factor(SCHL) , as.factor(SEX) , WKHP , as.factor(DIS)
           , as.factor(INDP) , as.factor(OCCP) , as.factor(NATIVITY) , as.factor(RAC1P))
detach(train)

v <- na.omit(v)

v <- data.frame(v)

names(v) <- list("wage", "year" , "FS" , "HHL" , "AGEP"
                 , "ENG" , "SCHL" , "SEX" , "WKHP" , "DIS"
                 , "INDP" , "OCCP" , "NATIVITY" , "RAC1P")

w <- subset(v,select=(wage))
v <- subset(v,select=c(-wage))

w <- as.matrix(w)
v <- as.matrix(v)

print("Starting LASSO")

lasso_test <- lars(x=v,y=w[,1],
            type="lasso",
            trace=TRUE,
            normalize=FALSE)

png("lassotime_coeff_unnorm.png",height=1000,width=1000)
plot(lasso_test)
dev.off()

print("Starting Cross Validation")

png("lassotime_cv_test_unnorm.png",height=500,width=500)

lasso_cv_test <- cv.lars(x=v, y=w[,1], K=10,
                    type="lasso",
                    trace=TRUE,
                    normalize=FALSE)
dev.off()


print("Done")

#########========########
##Prediction using LARS

attach(test)
v <- cbind(as.factor(year) , as.factor(FS) , as.factor(HHL) , AGEP
           , as.factor(ENG) , as.factor(SCHL) , as.factor(SEX) , WKHP , as.factor(DIS)
           , as.factor(INDP) , as.factor(OCCP) , as.factor(NATIVITY) , as.factor(RAC1P))
detach(test)

v <- na.omit(v)
v <- data.frame(v)

names(v) <- list("year" , "FS" , "HHL" , "AGEP"
                 , "ENG" , "SCHL" , "SEX" , "WKHP" , "DIS"
                 , "INDP" , "OCCP" , "NATIVITY" , "RAC1P")

lars_fit <- predict.lars(lasso_test,v,type="fit",s=0.40,mode="fraction")

larsfit <- lars_fit$fit

test$lassodiff <- test$wage - larsfit

print("Summary statistics for first GAM")
print(summary(abs(test$lassodiff)))
print(sum(abs(test$lassodiff)^2)/nrow(test))



