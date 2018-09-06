#### Import train file

train <- read.table("/home/stats/hansenga/train.txt",header=TRUE)
train <- train[complete.cases(train[,11]),]

source("edu_recode.R")

train <- train[,-c(33:112)]

train$PUMA10_new <- NULL
train$PUMA10_new1 <- NULL
train$PUMA00 <- NULL
train$PUMA00_new <- NULL