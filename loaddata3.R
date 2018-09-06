# script to load and arrange data
  a <- proc.time()
  
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
  combine <- combine[which(combine$AGEP>17),]
  rm(person,house)
  
  print(paste0("Dimension of Combine Data is ", dim(combine)))

  
  # adjustment factor
  combine$ADJUST <- combine$ADJINC.x/1000000
  
  combine$year <- floor(combine$SERIALNO/1000000000)
  
  personweights <- combine[216:295]
  
  print("Defining Variables to Keep")
  
  keep <- c("SERIALNO","year", "DIVISION",
            "PUMA10.x","REGION", "ST.x","PWGTP", 
            "ADJUST","FS", "HHL","RESMODE",
            "AGEP", "COW","ENG",
            "SCHL","SEX","WAGP", "WKHP", "DIS",
            "FOD1P","INDP", "NATIVITY", "OCCP12",
            "RAC1P")

#### Variables  
#   WAGEP - Yearly Wage (Response - Trying to predict)
#   SERIALNO - Person ID
#   DIVISON - Region of county
#   PUMA10.x - Public use microdata data area code
#   REGION - Region code
#   ST.x - State
#   PWGTP - Person Weights
#   ADJUST - yearly adjustment
#   FS - Food Stamps
#   HHL - Household language 
#   RESMODE - Response method
#   AGEP - Age
#   COW - Class of worker
#   ENG - Ability to Speak English
#   JWTR - Means of Transportation to work
#   MAR - Martical status
#   SCHG - Grade Level attending
#   SCHL - Educational attainment
#   SEX - Sex of respondant
#   WKHP - Usual hours worked in last 12 months
#   DIS - Disability
#   FOD1P/FOD2P - Field of Degree
#   HICOV - healthcare coverage
#   OCCP - Occupation
#   NATIVITY - native or foreign born
#   RAC1P - recoded detailed race code
### End of Variables  
  
  
  combine <- combine[keep]
  print(paste0("Dimension of Reduced Combine Data is ", dim(combine)))
  
  combine$COW1 <- combine$COW
  combine$ENG1 <- combine$ENG
  combine$FOD1P1 <- combine$FOD1P 
  combine$INDP1 <- combine$INDP
  combine$WKHP1 <- combine$WKHP
  combine$OCCP121 <- combine$OCCP12
  
  combine$OCCP <- as.numeric(as.character(combine$OCCP12))
                      
  combine$wage   <- combine$WAGP*combine$ADJUST
  combine$COW[is.na(combine$COW)] <- 0
  combine$ENG[is.na(combine$ENG)] <- 0
  combine$FOD1P  <- floor(combine$FOD1P/100)
  combine$OCCP   <- floor(combine$OCCP/100)
  combine$INDP   <- floor(combine$INDP/100)
  
  combine$FOD1P[is.na(combine$FOD1P)] <- 0
  combine$WKHP[is.na(combine$WKHP)]   <- 0
  combine$OCCP[is.na(combine$OCCP)] <- -1
  combine$INDP[is.na(combine$INDP)]   <- 0
  
  names(combine)[names(combine) == 'ST.x'] <- 'state'
  
  combine <- cbind(combine,personweights)
  
  rm(personweights,keep)
  
  print(paste0("Dimension of Final Combined Data is ", dim(combine)))
  
  print("Data Import Done")
  
  print("Creating Training and Testing Datasets")
  
  combine$sample <- sample(1:10, nrow(combine),replace=TRUE)
  
  test    <- combine[which(combine$sample>6),]
  train   <- combine[which(combine$sample<=6),]
  
  rm(combine)
  
  write.table(test, "test.txt", sep="\t")
  write.table(train, "train.txt", sep="\t")
  
  print("Data Setup Done")
  
  print(proc.time() - a)
  rm(a)