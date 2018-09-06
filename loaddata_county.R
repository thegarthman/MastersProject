# script to load and arrange data
  a <- proc.time()
  
  rm(test)
  rm(train)

  
  keep <- c("SERIALNO", "ST", "PUMA00","PUMA10" "AGEP")
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
  
  puma$PUMA00_new <- as.numeric(paste0(as.character(puma$state),as.character(puma$PUMA00)))
  puma$PUMA10_new <- as.numeric(paste0(as.character(puma$state),as.character(puma$PUMA10)))
  
  

  rm(akp,cap,orp,wap)
  print("Person Import Done")
  print(paste0("Dimension of Person Data is ", dim(puma)))
  
  print("Starting Final Merge")
  
  
  puma <- puma[which(puma$AGEP>17),]
  
  print(paste0("Dimension of PUMA Data is ", dim(puma)))

  
  puma <- puma[keep]
  
  train <- read.table("/home/stats/hansenga/train1.txt",header=TRUE,sep="\t") 
  test <- read.table("/home/stats/hansenga/test1.txt",header=TRUE,sep="\t")
  combine <- rbind(train,test)
  
  combine <- combine[order(combine$SERIALNO),]
  puma1    <- puma[order(puma$SERIALNO),]
  puma1$SERIALNO <- NULL
  puma1$AGEP <- NULL
  
  combine <- cbind(combine,puma1)

  
  
  print("Data Import Done")
  
  
  print("Data Setup Done")
  
  print(proc.time() - a)
  rm(a)