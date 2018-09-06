## Summaries ##

# summary statistics
sink("summary.txt")

aggregate(train$wage,train$year,FUN=mean)
aggregate(train$wage,train$state,FUN=mean)
aggregate(train$wage,train$SEX,FUN=mean)
aggregate(train$wage,train$FS,FUN=mean)
aggregate(train$wage,train$RESMODE,FUN=mean)
aggregate(train$wage,train$SCHL,FUN=mean)
aggregate(train$wage,train$INDP,FUN=mean)
aggregate(train$wage,train$NATIVITY,FUN=mean)
aggregate(train$wage,train$COW,FUN=mean)
aggregate(train$wage,train$RAC1P,FUN=mean)
aggregate(train$wage,train$HHL,FUN=mean)

unsink("summary.txt")


# scatterplots
png(file="wagebyhours.png".width=750,height=750)
plot(train$wage,train$WKHP)
dev.off()