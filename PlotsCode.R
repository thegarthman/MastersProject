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