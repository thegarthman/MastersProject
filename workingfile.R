### Thesis Project ###

house <- read.csv("A:/Garth/Google Drive/OSU/Potential Thesis Project/csv_hca/ss13hca.csv")
View(house)

person <- read.csv("A:/Garth/Google Drive/OSU/Potential Thesis Project/csv_pca/ss13pca.csv")
View(person)

all <- merge(house,person,by="SERIALNO")
rm(person)
rm(house)
