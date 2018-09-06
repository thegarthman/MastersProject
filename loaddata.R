# script to load and arrange data
  a <- proc.time()
  
  print("Checking for Survey Package")
  if(!is.element('survey', installed.packages()[,1]))
  {install.packages('survey',repos=86)
  }else {print("Survey library already installed")}
  
  # Housing Data
  akh <- read.csv("/home/stats/hansenga/ss13hak.csv")
  print("Alaska House Done")
  cah <- read.csv("/home/stats/hansenga/ss13hca.csv")
  print("California House Done")
  orh <- read.csv("/home/stats/hansenga/ss13hor.csv")
  print("Oregon House Done")
  wah <- read.csv("/home/stats/hansenga/ss13hwa.csv")
  print("Washington House Done")
  
  house <- rbind(akh,cah,orh,wah)
  rm(akh,cah,orh,wah)
  print("House Import Done")
  print(paste0("Dimension of House Data is ", dim(house)))
  
  # Person Data
  akp <- read.csv("/home/stats/hansenga/ss13pak.csv")
  print("Alaska Person Done")
  cap <- read.csv("/home/stats/hansenga/ss13pca.csv")
  print("California Person Done")
  orp <- read.csv("/home/stats/hansenga/ss13por.csv")
  print("Oregon Person Done")
  wap <- read.csv("/home/stats/hansenga/ss13pwa.csv")
  print("Washington Person Done")
  
  person <- rbind(akp,cap,orp,wap)

  rm(akp,cap,orp,wap)
  print("Person Import Done")
  print(paste0("Dimension of Person Data is ", dim(person)))
  
  print("Starting Final Merge")
  
  
  # crashes when merging the final datasheets
  combine <- merge(person,house,by="SERIALNO")
  combine <- combine[which(combine$AGEP>15),]
  rm(person,house)
  
  print(paste0("Dimension of Combine Data is ", dim(combine)))

  
  # adjustment factor
  combine$ADJUST <- combine$ADJINC.x/1000000
  
  combine$welfare <- combine$SSIP + combine$SSP + combine$PAP
  
  combine$year <- floor(combine$SERIALNO/1000000000)
  
  personweights <- combine[216:295]
  
  keep <- c("welfare", "SERIALNO", "DIVISION","year", 
            "PUMA10.x","REGION","ST.x","PWGTP",
            "ADJUST","BLD","FS","FINCP",
            "HHL","RESMODE","WIF","AGEP",
            "CIT","COW","ENG",
            "SCHL","SEX","WKL","WAGP",
            "DIS","NATIVITY")
  
  combine <- combine[keep]
                      
  combine$welfare <- combine$welfare*combine$ADJUST
  combine$wage <- combine$WAGP*combine$ADJUST
  combine$income <- combine$FINCP*combine$ADJUST
  combine$COW[is.na(combine$COW)] <- 0
  combine$ENG[is.na(combine$ENG)] <-0
  combine <- cbind(combine,personweights)
  
  print("Data Import Done")
  

  
  print(proc.time() - a)
  rm(a)