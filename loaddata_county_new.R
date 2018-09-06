# script to load and arrange data
  a <- proc.time()
  
  rm(test)
  rm(train)

  
  keep <- c("SERIALNO", "ST", "PUMA00","PUMA10", "AGEP")
  # Person Data
  akp <- read.csv("/home/stats/hansenga/ss13pak.csv")
  print("Alaska Person Done")
  cap <- read.csv("/home/stats/hansenga/ss13pca.csv")
  print("California Person Done")
  orp <- read.csv("/home/stats/hansenga/ss13por.csv")
  print("Oregon Person Done")
  wap <- read.csv("/home/stats/hansenga/ss13pwa.csv")
  print("Washington Person Done")
  
  puma <- rbind(akp,cap,orp,wap)
  puma <- puma[keep]
  
  puma <- puma[which(puma$AGEP>17),]
  
  rm(akp,cap,orp,wap)
  
  train <- read.table("/home/stats/hansenga/train1.txt",header=TRUE,sep="\t") 
  test <- read.table("/home/stats/hansenga/test1.txt",header=TRUE,sep="\t")
  combine <- rbind(train,test)
  
  combine <- combine[order(combine$SERIALNO),]
  puma1    <- puma[order(puma$SERIALNO),]
  puma1$SERIALNO <- NULL
  puma1$AGEP <- NULL
  
  combine <- cbind(combine,puma1)
  
  #### Merge 2000 and 2010 PUMA together into Single County Variable####
  
  
  
  # #### Merge PUMA00 to PUMA2010 First ####
  combine$PUMA00_new <- as.numeric(combine$PUMA00)
  combine$PUMA00_new[combine$PUMA00==-9] <- 0
  combine$PUMA00_new <- as.numeric(paste0(as.character(combine$state),as.character(combine$PUMA00_new)))
  
  
  combine <- combine[order(combine$PUMA00_new),]
  
  print(paste0("Dimension of Combine Data is ", dim(combine)))
  
  puma0010 <- read.csv("/home/stats/hansenga/puma00_puma2010.csv")
  
  puma0010$PUMA00_new <- as.numeric(puma0010$PUMA00_new)
  
  puma0010 <- puma0010[order(puma0010$PUMA00_new),]
  
  
  combine$PUMA10_new <- puma0010$PUMA10_new[match(combine$PUMA00_new,puma0010$PUMA00_new)]
  
  print(paste0("Dimension of combine Data is ", dim(combine)))
  
  
  
  #### Merge New and Old PUMA10 Files####
  # Working in combine dataframe now
  combine$PUMA10_new1 <- as.numeric(combine$PUMA10.x)
  combine$PUMA10_new1[combine$PUMA10.x==-9] <- 0
  
  combine$PUMA10_new1 <- paste0(as.character(combine$state),as.character(combine$PUMA10_new1))
  
  combine$PUMA10_new1 <- as.numeric(combine$PUMA10_new1)
  
  combine$PUMA10_final <- combine$PUMA10_new1 + combine$PUMA10_new
  
  print(summary(combine$PUMA10_final))
  
  #### Merge in County Level Data ####
  print(paste0("Dimension of combine Data is ", dim(combine)))
  county <- read.csv("/home/stats/hansenga/puma_county.csv")
  
  county$PUMA10_final <- as.numeric(county$PUMA10_final)
  county$county <- as.numeric(county$county)
  
  county <- county[order(county$PUMA10_final),]
  combine <- combine[order(combine$PUMA10_final),]
  
  combine$county <- county$county[match(combine$PUMA10_final,county$PUMA10_final)]
  combine$countyname <- county$cntyname[match(combine$PUMA10_final,county$PUMA10_final)]
  
  print(paste0("Dimension of combine Data is ", dim(combine)))

  
  print(proc.time() - a)
  rm(a)