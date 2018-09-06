
## Recode educational attainment ##
train$edu[train$SCHL == 1] <- 1                     # No schooling
train$edu[train$SCHL > 1 & train$SCHL <= 15] <- 2   # Did not graduate high school
train$edu[train$SCHL > 15 & train$SCHL <= 17] <- 3  # High school, GED, or equivalent
train$edu[train$SCHL > 17 & train$SCHL <= 19] <- 4  # Some college
train$edu[train$SCHL == 20] <- 5                    # Associates
train$edu[train$SCHL == 21] <- 6                    # Bachelors
train$edu[train$SCHL == 22] <- 7                    # Masters
train$edu[train$SCHL == 23] <- 8                    # Professional degress beyond bachelor
train$edu[train$SCHL == 24] <- 9                    # Doctorate degree