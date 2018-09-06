### Set up Training and Testing Data Sets

# Use 30% of original data set for test

combine$sample <- sample(1:10, nrow(combine),replace=TRUE)

test    <- combine[which(combine$sample>6),]
train   <- combine[which(combine$sample<=6),]

rm(combine)