#### Recoding for Test Dataset Importation ####

test <- read.table("/home/stats/hansenga/test.txt",header=TRUE)

## Remove GQ from dataset ##
test <- test[complete.case(test[,c(11)]),]

## Recode educational attainment ##
test$edu[test$SCHL = 1] <- 1           # No schooling
test$edu[test$SCHL > 1 & <= 15] <- 2   # Did not graduate high school
test$edu[test$SCHL > 15 & <= 17] <- 3  # High school, GED, or equivalent
test$edu[test$SCHL > 17 & <= 19] <- 4  # Some college
test$edu[test$SCHL = 20] <- 5          # Associates
test$edu[test$SCHL = 21] <- 6          # Bachelors
test$edu[test$SCHL = 22] <- 7          # Masters
test$edu[test$SCHL = 23] <- 8          # Professional degress beyond bachelor
test$edu[test$SCHL = 24] <- 9          # Doctorate degree