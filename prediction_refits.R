#### Fitting "Best" Models to People who have Wage > 0 ####
# Fit 1 linear model
# Fit 1 tree model
# Fit 1 additive model

library(rpart)
library(gam)
library(ggplot2)
library(scales)

a <- proc.time()


#===================================#
# Testing Models with Wages above 0 #
#===================================#
print("===Fitting Models for Wage above 0===")
test_best <- test[which(test$wage>0),]
test_best <- test_best[ -c(33:147) ]

#### Best Linear Model ####
print("Refitting Linear Model 4")

lmfit_best <- lm(wage ~ factor(state) + factor(FS) +  AGEP
                 + factor(ENG) + factor(SCHL) + factor(SEX) + WKHP + factor(DIS)
                 + factor(INDP) + factor(OCCP) + factor(NATIVITY) + factor(RAC1P) + AGEP*WKHP,
              weights=PWGTP,
              data=train[which(train$wage>0),]
              )

test_best$lmfit_best1  <- predict(lmfit_best,test_best)
test_best$lmfit_best1_error  <- test_best$wage - test_best$lmfit_best1
print("Summary statistics for First Linear Model")
print(summary(abs(test_best$lmfit_best1_error)))
print(sqrt(sum(abs(test_best$lmfit_best1_error)^2)/nrow(test_best)))

png("present_lm1_w0.png",height=500,width=750)
p <- ggplot(test_best,aes(wage,lmfit_best1))
p <- p + labs(title = "Linear Model: Actual vs. Predicted Wage") + 
         labs(x = "Actual Wage") + 
         labs(y = "Predicted Wage")
p <- p + scale_x_continuous(labels = comma) + scale_y_continuous(labels = comma) 
p <- p + theme(axis.title=element_text(size=16),
          title=element_text(size=20,face="bold"))+
          geom_point(aes(colour = abs(lmfit_best1_error))) +
          geom_abline(intercept = 0, slope = 1,colour = "red", size = 2)+
          scale_color_continuous(name="Pred. Error",
          labels=comma)
print(p)
dev.off()

rm(lmfit_best)

### Best Linear Model with Log(Wage) ####
print("Refitting Linear Model 4 with Log(Wage)")
lmfit_best_log <- lm(log(wage) ~ factor(state) + factor(FS) +  AGEP
                 + factor(ENG) + factor(SCHL) + factor(SEX) + WKHP + factor(DIS)
                 + factor(INDP) + factor(OCCP) + factor(NATIVITY) + factor(RAC1P) + AGEP*WKHP,
              weights=PWGTP,
              data=train[which(train$wage>0),]
              )

test_best$lmfit_best2  <- predict(lmfit_best_log,test_best)
test_best$lmfit_best2  <- exp(test_best$lmfit_best2)
test_best$lmfit_best2_error  <- test_best$wage - test_best$lmfit_best2
print("Summary statistics for Second Linear Model")
print(summary(abs(test_best$lmfit_best2_error)))
print(sqrt(sum(abs(test_best$lmfit_best2_error)^2)/nrow(test_best)))

png("present_lm2_w0.png",height=500,width=750)
p <- ggplot(test_best,aes(wage,lmfit_best2))
p <- p + labs(title = "Linear Model with Log Response: Actual vs. Predicted Wage") + 
         labs(x = "Actual Wage") + 
         labs(y = "Predicted Wage")
p <- p + scale_x_continuous(labels = comma) + scale_y_continuous(labels = comma) 
p <- p + theme(axis.title=element_text(size=16),
          title=element_text(size=20,face="bold"))+
          geom_point(aes(colour = abs(lmfit_best2_error))) +
          geom_abline(intercept = 0, slope = 1,colour = "red", size = 2)+
          scale_color_continuous(name="Pred. Error",
          labels=comma)
print(p)
dev.off()

rm(lmfit_best_log)




#### Best Regression Tree Model ####
print("Refitting Regression Tree Model 1")
treefit_best <- rpart(wage ~ factor(state) + factor(FS) +  AGEP
                 + factor(ENG) + factor(SCHL) + factor(SEX) + WKHP + factor(DIS)
                 + factor(INDP) + factor(OCCP) + factor(NATIVITY) + factor(RAC1P),
                   weights=PWGTP,
                   data=train[which(train$wage>0),]
                   )

test_best$treefit_best <- predict(treefit_best,test_best)
test_best$treefit_best_error <- test_best$wage - test_best$treefit_best
print("Summary statistics for Regression Tree Model")
print(summary(abs(test_best$treefit_best_error)))
print(sqrt(sum(abs(test_best$treefit_best_error)^2)/nrow(test_best)))

png("present_tree_w0.png",height=500,width=750)
p <- ggplot(test_best,aes(wage,treefit_best))
p <- p + labs(title = "Linear Model with Log Response: Actual vs. Predicted Wage") + 
         labs(x = "Actual Wage") + 
         labs(y = "Predicted Wage")
p <- p + scale_x_continuous(labels = comma) + scale_y_continuous(labels = comma) 
p <- p + theme(axis.title=element_text(size=16),
          title=element_text(size=20,face="bold"))+
          geom_point(aes(colour = abs(treefit_best_error))) +
          geom_abline(intercept = 0, slope = 1,colour = "red", size = 2)+
          scale_color_continuous(name="Pred. Error",
          labels=comma)
print(p)
dev.off()

rm(treefit_best)



print("Refitting Additive Model 3")
gam_best <- gam(
  wage ~ s(year,3) + factor(state) + factor(FS) +  s(AGEP,3)
                  + factor(ENG) + factor(SCHL) + factor(SEX) + s(WKHP,3) + factor(DIS)
                  + factor(INDP) + factor(OCCP) + factor(NATIVITY) + factor(RAC1P)
                  + s(AGEP*WKHP,3),
  weights=PWGTP,
  data=train[which(train$wage<300000),],
  trace=TRUE
)

test_best$gamfit_best  <- predict(gam_best,test_best)
test_best$gamfit_best_error  <- test_best$wage - test_best$gamfit_best

print("Summary statistics for Regression Tree Model")
print(summary(abs(test_best$gamfit_best_error)))
print(sqrt(sum(abs(test_best$gamfit_best_error )^2)/nrow(test_best)))

png("present_gam_w0.png",height=500,width=750)
p <- ggplot(test_best,aes(wage,gamfit_best))
p <- p + labs(title = "Additive Model: Actual vs. Predicted Wage") + 
         labs(x = "Actual Wage") + 
         labs(y = "Predicted Wage")
p <- p + scale_x_continuous(labels = comma) + scale_y_continuous(labels = comma) 
p <- p + theme(axis.title=element_text(size=16),
          title=element_text(size=20,face="bold"))+
          geom_point(aes(colour = abs(gamfit_best_error))) +
          geom_abline(intercept = 0, slope = 1,colour = "red", size = 2)+
          scale_color_continuous(name="Pred. Error",
          labels=comma)
print(p)
dev.off()

rm(gam_best)




#=========================================#
# Testing Models with Wages below 300,000 #
#=========================================#
print("===Fitting Models for Wage below 300,000===")

test_best <- test[which(test$wage<300000),]
test_best <- test_best[ -c(33:147) ]

#### Best Linear Model ####
print("Refitting Linear Model 4")

lmfit_best <- lm(wage ~ factor(state) + factor(FS) +  AGEP
                 + factor(ENG) + factor(SCHL) + factor(SEX) + WKHP + factor(DIS)
                 + factor(INDP) + factor(OCCP) + factor(NATIVITY) + factor(RAC1P) + AGEP*WKHP,
              weights=PWGTP,
              data=train[which(train$wage<300000),]
              )

test_best$lmfit_best1  <- predict(lmfit_best,test_best)
test_best$lmfit_best1_error  <- test_best$wage - test_best$lmfit_best1
print("Summary statistics for First Linear Model")
print(summary(abs(test_best$lmfit_best1_error)))
print(sqrt(sum(abs(test_best$lmfit_best1_error)^2)/nrow(test_best)))

png("present_lm1_w3.png",height=500,width=750)
p <- ggplot(test_best,aes(wage,lmfit_best1))
p <- p + labs(title = "Linear Model: Actual vs. Predicted Wage") + 
         labs(x = "Actual Wage") + 
         labs(y = "Predicted Wage")
p <- p + scale_x_continuous(labels = comma) + scale_y_continuous(labels = comma) 
p <- p + theme(axis.title=element_text(size=16),
          title=element_text(size=20,face="bold"))+
          geom_point(aes(colour = abs(lmfit_best1_error))) +
          geom_abline(intercept = 0, slope = 1,colour = "red", size = 2)+
          scale_color_continuous(name="Pred. Error",
          labels=comma)
print(p)
dev.off()

rm(lmfit_best)

#### Best Linear Model with Log(Wage) ####
#print("Refitting Linear Model 4 with Log(Wage)")
#lmfit_best_log <- lm(log(wage) ~ factor(state) + factor(FS) +  AGEP
#                 + factor(ENG) + factor(SCHL) + factor(SEX) + WKHP + factor(DIS)
#                 + factor(INDP) + factor(OCCP) + factor(NATIVITY) + factor(RAC1P) + AGEP*WKHP,
#              weights=PWGTP,
#              data=train[which(train$wage<300000),]
#              )
#
#test_best$lmfit_best2  <- predict(lmfit_best_log,test_best)
#test_best$lmfit_best2  <- exp(test_best$lmfit_best2)
#test_best$lmfit_best2_error  <- test_best$wage - test_best$lmfit_best2
#print("Summary statistics for Second Linear Model")
#print(summary(abs(test_best$lmfit_best2_error)))
#print(sqrt(sum(abs(test_best$lmfit_best2_error)^2)/nrow(test_best)))
#rm(lmfit_best_log)


#### Best Regression Tree Model ####
print("Refitting Regression Tree Model 1")
treefit_best <- rpart(wage ~ factor(state) + factor(FS) +  AGEP
                 + factor(ENG) + factor(SCHL) + factor(SEX) + WKHP + factor(DIS)
                 + factor(INDP) + factor(OCCP) + factor(NATIVITY) + factor(RAC1P) ,
                   weights=PWGTP,
                   data=train[which(train$wage<300000),]
                   )

test_best$treefit_best <- predict(treefit_best,test_best)
test_best$treefit_best_error <- test_best$wage - test_best$treefit_best
print("Summary statistics for Regression Tree Model")
print(summary(abs(test_best$treefit_best_error)))
print(sqrt(sum(abs(test_best$treefit_best_error)^2)/nrow(test_best)))

png("present_tree_w3.png",height=500,width=750)
p <- ggplot(test_best,aes(wage,treefit_best))
p <- p + labs(title = "Linear Model with Log Response: Actual vs. Predicted Wage") + 
         labs(x = "Actual Wage") + 
         labs(y = "Predicted Wage")
p <- p + scale_x_continuous(labels = comma) + scale_y_continuous(labels = comma) 
p <- p + theme(axis.title=element_text(size=16),
          title=element_text(size=20,face="bold"))+
          geom_point(aes(colour = abs(treefit_best_error))) +
          geom_abline(intercept = 0, slope = 1,colour = "red", size = 2)+
          scale_color_continuous(name="Pred. Error",
          labels=comma)
print(p)
dev.off()

rm(treefit_best)



print("Refitting Additive Model 3")
gam_best <- gam(
  wage ~ s(year,3) + factor(state) + factor(FS) +  s(AGEP,3)
                  + factor(ENG) + factor(SCHL) + factor(SEX) + s(WKHP,3) + factor(DIS)
                  + factor(INDP) + factor(OCCP) + factor(NATIVITY) + factor(RAC1P)
                  + s(AGEP*WKHP,3),
  weights=PWGTP,
  data=train[which(train$wage<300000),],
  trace=TRUE
)

test_best$gamfit_best  <- predict(gam_best,test_best)
test_best$gamfit_best_error  <- test_best$wage - test_best$gamfit_best

print("Summary statistics for Regression Tree Model")
print(summary(abs(test_best$gamfit_best_error)))
print(sqrt(sum(abs(test_best$gamfit_best_error )^2)/nrow(test_best)))

png("present_gam_w3.png",height=500,width=750)
p <- ggplot(test_best,aes(wage,gamfit_best))
p <- p + labs(title = "Additive Model: Actual vs. Predicted Wage") + 
         labs(x = "Actual Wage") + 
         labs(y = "Predicted Wage")
p <- p + scale_x_continuous(labels = comma) + scale_y_continuous(labels = comma) 
p <- p + theme(axis.title=element_text(size=16),
          title=element_text(size=20,face="bold"))+
          geom_point(aes(colour = abs(gamfit_best_error))) +
          geom_abline(intercept = 0, slope = 1,colour = "red", size = 2)+
          scale_color_continuous(name="Pred. Error",
          labels=comma)
print(p)
dev.off()

rm(gam_best)





#=====================================================#
# Testing Models with Wages above 0 and below 300,000 #
#=====================================================#
print("===Fitting Models for Wage above 0 and below 300,000===")
test_best <- test[which(test$wage<300000 & test$wage>0),]
test_best <- test_best[ -c(33:147) ]

#### Best Linear Model ####
print("Refitting Linear Model 4")

lmfit_best <- lm(wage ~ factor(state) + factor(FS) +  AGEP
                 + factor(ENG) + factor(SCHL) + factor(SEX) + WKHP + factor(DIS)
                 + factor(INDP) + factor(OCCP) + factor(NATIVITY) + factor(RAC1P) + AGEP*WKHP,
              weights=PWGTP,
              data=train[which(train$wage<300000 & train$wage>0),]
              )

test_best$lmfit_best1  <- predict(lmfit_best,test_best)
test_best$lmfit_best1_error  <- test_best$wage - test_best$lmfit_best1
print("Summary statistics for First Linear Model")
print(summary(abs(test_best$lmfit_best1_error)))
print(sqrt(sum(abs(test_best$lmfit_best1_error)^2)/nrow(test_best)))

png("present_lm1_w30.png",height=500,width=750)
p <- ggplot(test_best,aes(wage,lmfit_best1))
p <- p + labs(title = "Linear Model: Actual vs. Predicted Wage") + 
         labs(x = "Actual Wage") + 
         labs(y = "Predicted Wage")
p <- p + scale_x_continuous(labels = comma) + scale_y_continuous(labels = comma) 
p <- p + theme(axis.title=element_text(size=16),
          title=element_text(size=20,face="bold"))+
          geom_point(aes(colour = abs(lmfit_best1_error))) +
          geom_abline(intercept = 0, slope = 1,colour = "red", size = 2)+
          guides(fill = guide_legend(title = "Prediction Error"))
print(p)
dev.off()

rm(lmfit_best)

#### Best Linear Model with Log(Wage) ####
print("Refitting Linear Model 4 with Log(Wage)")
lmfit_best_log <- lm(log(wage) ~ factor(state) + factor(FS) +  AGEP
                 + factor(ENG) + factor(SCHL) + factor(SEX) + WKHP + factor(DIS)
                 + factor(INDP) + factor(OCCP) + factor(NATIVITY) + factor(RAC1P) + AGEP*WKHP,
              weights=PWGTP,
              data=train[which(train$wage<300000 & train$wage>0),]
              )

test_best$lmfit_best2  <- predict(lmfit_best_log,test_best)
test_best$lmfit_best2  <- exp(test_best$lmfit_best2)
test_best$lmfit_best2_error  <- test_best$wage - test_best$lmfit_best2
print("Summary statistics for Second Linear Model")
print(summary(abs(test_best$lmfit_best2_error)))
print(sqrt(sum(abs(test_best$lmfit_best2_error)^2)/nrow(test_best)))


png("present_lm2_w30.png",height=500,width=750)
p <- ggplot(test_best,aes(wage,lmfit_best2))
p <- p + labs(title = "Linear Model with Log Response: Actual vs. Predicted Wage") + 
         labs(x = "Actual Wage") + 
         labs(y = "Predicted Wage")
p <- p + scale_x_continuous(labels = comma) + scale_y_continuous(labels = comma) 
p <- p + theme(axis.title=element_text(size=16),
          title=element_text(size=20,face="bold"))+
          geom_point(aes(colour = abs(lmfit_best2_error))) +
          geom_abline(intercept = 0, slope = 1,colour = "red", size = 2)+
          scale_color_continuous(name="Pred. Error",
          labels=comma)
print(p)
dev.off()

rm(lmfit_best_log)


#### Best Regression Tree Model ####
print("Refitting Regression Tree Model 1")
treefit_best <- rpart(wage ~ factor(state) + factor(FS) +  AGEP
                 + factor(ENG) + factor(SCHL) + factor(SEX) + WKHP + factor(DIS)
                 + factor(INDP) + factor(OCCP) + factor(NATIVITY) + factor(RAC1P) ,
                   weights=PWGTP,
                   data=train[which(train$wage<300000 & train$wage>0),]
                   )

test_best$treefit_best <- predict(treefit_best,test_best)
test_best$treefit_best_error <- test_best$wage - test_best$treefit_best
print("Summary statistics for Regression Tree Model")
print(summary(abs(test_best$treefit_best_error)))
print(sqrt(sum(abs(test_best$treefit_best_error)^2)/nrow(test_best)))

png("present_tree_w30.png",height=500,width=750)
p <- ggplot(test_best,aes(wage,treefit_best))
p <- p + labs(title = "Linear Model with Log Response: Actual vs. Predicted Wage") + 
         labs(x = "Actual Wage") + 
         labs(y = "Predicted Wage")
p <- p + scale_x_continuous(labels = comma) + scale_y_continuous(labels = comma) 
p <- p + theme(axis.title=element_text(size=16),
          title=element_text(size=20,face="bold"))+
          geom_point(aes(colour = abs(treefit_best_error))) +
          geom_abline(intercept = 0, slope = 1,colour = "red", size = 2)+
          scale_color_continuous(name="Pred. Error",
          labels=comma)
print(p)
dev.off()

rm(treefit_best)



print("Refitting Additive Model 3")
gam_best <- gam(
  wage ~ s(year,3)+ factor(state) + factor(FS) +  s(AGEP,3)
                  + factor(ENG) + factor(SCHL) + factor(SEX) + s(WKHP,3) + factor(DIS)
                  + factor(INDP) + factor(OCCP) + factor(NATIVITY) + factor(RAC1P)
                  + s(AGEP*WKHP,3),
  weights=PWGTP,
  data=train[which(train$wage<300000 & train$wage>0),],
  trace=TRUE
)

test_best$gamfit_best  <- predict(gam_best,test_best)
test_best$gamfit_best_error  <- test_best$wage - test_best$gamfit_best

print("Summary statistics for Regression Tree Model")
print(summary(abs(test_best$gamfit_best_error)))
print(sqrt(sum(abs(test_best$gamfit_best_error )^2)/nrow(test_best)))

png("present_gam_w30.png",height=500,width=750)
p <- ggplot(test_best,aes(wage,gamfit_best))
p <- p + labs(title = "Linear Model with Log Response: Actual vs. Predicted Wage") + 
         labs(x = "Actual Wage") + 
         labs(y = "Predicted Wage")
p <- p + scale_x_continuous(labels = comma) + scale_y_continuous(labels = comma) 
p <- p + theme(axis.title=element_text(size=16),
          title=element_text(size=20,face="bold"))+
          geom_point(aes(colour = abs(gamfit_best_error))) +
          geom_abline(intercept = 0, slope = 1,colour = "red", size = 2)+
          scale_color_continuous(name="Pred. Error",
          labels=comma)
print(p)
dev.off()

rm(gam_best)







print(proc.time() - a)

