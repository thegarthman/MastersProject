# preliminary data messing around with

cal12h <- read.csv("A:/Garth/Desktop/csv_hca/ss12hca.csv")
cal12p <- read.csv("A:/Garth/Desktop/csv_pca/ss12pca.csv")
View(cal12h)
View(cal12p)


cal12all <- merge(cal12h,cal12p, by="SERIALNO")
View(cal12all)
rm(cal12h);rm(cal12p)

cal12p$year <- floor(cal12p$SERIALNO/1000000000)-2007
range(cal12$year)

# install.packages("survey")
library(survey)

# test glm function
srd <- svrepdesign(
  variables=cal12p$AGE, 
  type="BRR", 
  repweights="PWGTP[1-80]+")

srd <- svrepdesign(variables=cal12p$AGE,
            repweights=cal12p[210:290],
            weights=cal12p$PWGTP,combined.weights=TRUE,
            type="Fay",rho=(1-1/sqrt(4)),scale=1,rscales=1)

mod1 <- svyglm(cal12p$SSP ~ cal12p$AGE,design=srd,na.action=TRUE)
