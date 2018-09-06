#### Plots of Data ####

sample <- read.delim("A:/Garth/Google Drive/OSU/Thesis Project/sample.txt")
View(sample)

library(ggplot2)
library(scales)


# Histogram of Wage for Paper
png("present_wage.png",height=500,width=750)
p <- ggplot(train,aes(x=wage))
p <- p + labs(title = "Histogram of Wage") + labs(x = "Wage") + labs(y = "Count")
p <- p + scale_x_continuous(labels = comma) + scale_y_continuous(labels = comma) 
p + theme(axis.title=element_text(size=16),
          title=element_text(size=20,face="bold"))+
  geom_histogram(colour = "white", fill = "black",binwidth=10000)
dev.off()


# Histogram of Age for Paper
png("present_age.png",height=500,width=750)
p <- ggplot(train,aes(x=AGEP))
p <- p + labs(title = "Histogram of Age") + labs(x = "Age") + labs(y = "Count")
p <- p + scale_x_continuous(labels = comma) + scale_y_continuous(labels = comma) 
p + theme(axis.title=element_text(size=16),
          title=element_text(size=20,face="bold"))+
  geom_histogram(colour = "white", fill = "black",binwidth=5)
dev.off()


# Histogram of Hours Worked for Paper
png("present_wkhp.png",height=500,width=750)
p <- ggplot(train,aes(x=WKHP))
p <- p + labs(title = "Histogram of Hours Worked Per Week") + labs(x = "Hours Worked Per Week") + labs(y = "Count")
p <- p + scale_x_continuous(labels = comma) + scale_y_continuous(labels = comma) 
p + theme(axis.title=element_text(size=16),
          title=element_text(size=20,face="bold"))+
  geom_histogram(colour = "white", fill = "black",binwidth=5)
dev.off()


# Scatterplot of actual vs predicted
# Plot one from each model type
# Linear Model 4
png("present_lm4.png",height=500,width=750)
p <- ggplot(test,aes(wage,lmfit4))
p <- p + labs(title = "Actual Wage vs Predicted Wage for Linear Model 4") + 
         labs(x = "Actual Wage") + 
         labs(y = "Predicted Wage")
p <- p + scale_x_continuous(labels = comma) + scale_y_continuous(labels = comma) 
p + theme(axis.title=element_text(size=16),
          title=element_text(size=20,face="bold"))+
          geom_point(aes(colour = abs(diff4))) +
          geom_abline(intercept = 0, slope = 1,colour = "red", size = 2)+
          scale_color_continuous(name="Pred. Error",
          labels=comma)
dev.off()


# Side by Side Histograms
png("present_actual.png",height=500,width=750)
p <- ggplot(test,aes(wage))
p <- p + labs(title = "Actual Wage") + 
  labs(x = "Actual Wage") + 
  labs(y = "Count")
p <- p + scale_x_continuous(labels = comma) + scale_y_continuous(labels = comma) 
p + theme(axis.title=element_text(size=16),
          title=element_text(size=20,face="bold"))+
          geom_histogram(colour = "white", fill = "black",binwidth=10000)
dev.off()


png("present_lm4_pred.png",height=500,width=750)
p <- ggplot(test,aes(lmfit4))
p <- p + labs(title = "Linear Model Predicted Wage") + 
  labs(x = "Predictied Wage") + 
  labs(y = "Count")
p <- p + scale_x_continuous(labels = comma) + scale_y_continuous(labels = comma) 
p + theme(axis.title=element_text(size=16),
          title=element_text(size=20,face="bold"))+
          geom_histogram(colour = "white", fill = "black",binwidth=10000)
dev.off()

png("present_tree_pred.png",height=500,width=750)
p <- ggplot(test,aes(treefit2))
p <- p + labs(title = "Regression Tree Predicted Wage") + 
  labs(x = "Predictied Wage") + 
  labs(y = "Count")
p <- p + scale_x_continuous(labels = comma) + scale_y_continuous(labels = comma) 
p + theme(axis.title=element_text(size=16),
          title=element_text(size=20,face="bold"))+
  geom_histogram(colour = "white", fill = "black",binwidth=10000)
dev.off()

png("present_gam_pred.png",height=500,width=750)
p <- ggplot(test,aes(gamfit3))
p <- p + labs(title = "Additive Model Predicted Wage") + 
  labs(x = "Predictied Wage") + 
  labs(y = "Count")
p <- p + scale_x_continuous(labels = comma) + scale_y_continuous(labels = comma) 
p + theme(axis.title=element_text(size=16),
          title=element_text(size=20,face="bold"))+
  geom_histogram(colour = "white", fill = "black",binwidth=10000)
dev.off()

png("present_glm_pred.png",height=500,width=750)
p <- ggplot(test,aes(lmefit3))
p <- p + labs(title = "Mixed Effects Model Predicted Wage") + 
  labs(x = "Predictied Wage") + 
  labs(y = "Count")
p <- p + scale_x_continuous(labels = comma) + scale_y_continuous(labels = comma) 
p + theme(axis.title=element_text(size=16),
          title=element_text(size=20,face="bold"))+
  geom_histogram(colour = "white", fill = "black",binwidth=10000)
dev.off()

png("present_lasso_pred.png",height=500,width=750)
p <- ggplot(test,aes(larsfit))
p <- p + labs(title = "LASSO Model Predicted Wage") + 
  labs(x = "Predictied Wage") + 
  labs(y = "Count")
p <- p + scale_x_continuous(labels = comma) + scale_y_continuous(labels = comma) 
p + theme(axis.title=element_text(size=16),
          title=element_text(size=20,face="bold"))+
  geom_histogram(colour = "white", fill = "black",binwidth=10000)
dev.off()



# Regression Tree 1
png("present_tree2.png",height=500,width=750)
p <- ggplot(test,aes(wage,treefit1))
p <- p + labs(title = "Actual Wage vs Predicted Wage for Regression Tree 1") + 
         labs(x = "Actual Wage") + 
         labs(y = "Predicted Wage")
p <- p + scale_x_continuous(labels = comma) + scale_y_continuous(labels = comma) 
p + theme(axis.title=element_text(size=16),
          title=element_text(size=20,face="bold"))+
          geom_point(aes(colour = abs(treediff1))) +
          geom_abline(intercept = 0, slope = 1,colour = "red", size = 2)+
          guides(fill = guide_legend(title = "Prediction Error"))+
          scale_color_continuous(name="Pred. Error",
          labels=comma)
dev.off()


# Additive Model 3
png("present_gam3.png",height=500,width=750)
p <- ggplot(test,aes(wage,gamfit3))
p <- p + labs(title = "Actual Wage vs Predicted Wage for Additive Model 3") + 
         labs(x = "Actual Wage") + 
         labs(y = "Predicted Wage")
p <- p + scale_x_continuous(labels = comma) + scale_y_continuous(labels = comma) 
p + theme(axis.title=element_text(size=16),
          title=element_text(size=20,face="bold"))+
          geom_point(aes(colour = abs(gamdiff3))) +
          geom_abline(intercept = 0, slope = 1,colour = "red", size = 2)+
          guides(fill = guide_legend(title = "Prediction Error"))+
          scale_color_continuous(name="Pred. Error",
          labels=comma)
dev.off()


# Mixed Model 3
png("present_glm3.png",height=500,width=750)
p <- ggplot(test,aes(wage,lmefit3))
p <- p + labs(title = "Actual Wage vs Predicted Wage for Mixed Model 3") + 
  labs(x = "Actual Wage") + 
  labs(y = "Predicted Wage")
p <- p + scale_x_continuous(labels = comma) + scale_y_continuous(labels = comma) 
p + theme(axis.title=element_text(size=16),
          title=element_text(size=20,face="bold"))+
  geom_point(aes(colour = abs(lmefit3))) +
  geom_abline(intercept = 0, slope = 1,colour = "red", size = 2)+
  guides(fill = guide_legend(title = "Prediction Error"))+
  scale_color_continuous(name="Pred. Error",
                         labels=comma)
dev.off()


## Plots for follow-up ##
test_best <- test[which(test$wage<300000 & test$wage>0),]
test_best <- test_best[ -c(33:147) ]

png("present_actual_followup.png",height=500,width=750)
p <- ggplot(test_best,aes(wage))
p <- p + labs(title = "Actual Wage") + 
  labs(x = "Actual Wage") + 
  labs(y = "Count")
p <- p + scale_x_continuous(labels = comma) + scale_y_continuous(labels = comma) 
p + theme(axis.title=element_text(size=16),
          title=element_text(size=20,face="bold"))+
  geom_histogram(colour = "white", fill = "black",binwidth=10000)
dev.off()

print("Refitting Linear Model 4 with Log(Wage)")
lmfit_best_log <- lm(log(wage) ~ factor(state) + factor(FS) +  AGEP
                     + factor(ENG) + factor(SCHL) + factor(SEX) + WKHP + factor(DIS)
                     + factor(INDP) + factor(OCCP) + factor(NATIVITY) + factor(RAC1P) + AGEP*WKHP,
                     weights=PWGTP,
                     data=train[which(train$wage<300000 & train$wage>0),]
)

test_best$lmfit_best2  <- predict(lmfit_best_log,test_best)
test_best$lmfit_best2  <- exp(test_best$lmfit_best2)
test_best <- 
png("present_loglinearfit_followup.png",height=500,width=750)
p <- ggplot(test_best[which(test_best$lmfit_best2<300000),],aes(lmfit_best2))
p <- p + labs(title = "Linear Model with Log Response Predicted Wage") + 
  labs(x = "Actual Wage") + 
  labs(y = "Count")
p <- p + scale_x_continuous(labels = comma) + scale_y_continuous(labels = comma) 
p + theme(axis.title=element_text(size=16),
          title=element_text(size=20,face="bold"))+
  geom_histogram(colour = "white", fill = "black",binwidth=10000)
dev.off()



p1 <- qplot(x=AGEP,y=wage,data=sample)
p1 <- p1 + labs(title = "Plot of Wage Against Age") + labs(x = "Age") + labs(y = "Wage")
p1 + theme_bw() + scale_y_continuous(labels = comma)

p2 <- qplot(x=WKHP,y=wage,data=sample)
p2 <- p2 + labs(title = "Plot of Wage Against Hours Worked") + labs(x = "Hours Worked") + labs(y = "Wage")
p2 + theme_bw() + scale_y_continuous(labels = comma)



#### Looking at prediction Errors ####
testsample <- read.delim("A:/Garth/Google Drive/OSU/Thesis Project/testsample.txt")
View(testsample)

# Variables of interest:
# treediff1 and treediff2

qplot(abs(testsample$treediff1),data=testsample,geom="histogram",binwidth=10000)

# Doesn't look like there is anything werid

#### ####