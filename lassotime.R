## LASSO Implementation ##

library("lars")

print("Building Data Set")

attach(oregon)
v <- cbind(wage, as.factor(year) , as.factor(FS) , as.factor(HHL) , as.factor(RESMODE) , AGEP
           , as.factor(COW) , as.factor(ENG) , as.factor(SCHL) , as.factor(SEX) , WKHP , as.factor(DIS)
           , as.factor(FOD1P) , as.factor(INDP) , as.factor(OCCP) , as.factor(NATIVITY) , as.factor(RAC1P))
detach(oregon)

v <- na.omit(v)

v <- data.frame(v)

names(v) <- list("wage", "year" , "FS" , "HHL" , "RESMODE" , "AGEP"
                 , "COW" , "ENG" , "SCHL" , "SEX" , "WKHP" , "DIS"
                 , "FOD1P" , "INDP" , "OCCP" , "NATIVITY" , "RAC1P")

w <- subset(v,select=(wage))
v <- subset(v,select=c(-wage))

w <- as.matrix(w)
v <- as.matrix(v)

print("Starting LASSO")

lasso <- lars(x=v,y=w[,1],
         type="lasso",
         trace=TRUE)


save.image()

print("Done")