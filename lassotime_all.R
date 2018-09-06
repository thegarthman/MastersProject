## LASSO Implementation ##

library("lars")

print("Building Data Set")

attach(train)
v <- cbind(wage, as.factor(county), as.factor(year) , as.factor(FS) , AGEP
           , as.factor(ENG) , as.factor(edu) , as.factor(SEX) , WKHP , as.factor(DIS)
           , as.factor(indp) , as.factor(occp) , as.factor(NATIVITY) , as.factor(RAC1P))
detach(train)

v <- na.omit(v)

v <- data.frame(v)

names(v) <- list("wage", "county", "year" , "FS" , "AGEP"
                 , "ENG" , "edu" , "SEX" , "WKHP" , "DIS"
                 , "INDP" , "OCCP" , "NATIVITY" , "RAC1P")

w <- subset(v,select=(wage))
v <- subset(v,select=c(-wage))

w <- as.matrix(w)
v <- as.matrix(v)

print("Starting LASSO")

lasso_red <- lars(x=v,y=w[,1],
         type="lasso",
         normalize=FALSE,
         trace=TRUE)


# save.image()

png("lasso_red.png",height=1000,width=1000)
plot(lasso_red)
dev.off()

print("Done")