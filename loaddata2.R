### load data for commute ###
a <- proc.time()

newyork <- rep(03701:04114)
losangeles <- rep(03701:03769)
chicago <- rep(03501:03532)
houston <- rep(04601:04621)
phil <- rep(03201:03211)
phoe <- rep(00100:00134)
sanan <- rep(05901:05906)
sandiego <- rep(07304:07322)
dallas <- rep(02200:02322)
sanjose <- rep(08502:08514)

### House
azh <- read.csv("/home/stats/hansenga/data/ss13haz.csv")
print("Arizona House Done")
cah <- read.csv("/home/stats/hansenga/data/ss13hca.csv")
print("California House Done")
ilh <- read.csv("/home/stats/hansenga/data/ss13hil.csv")
print("Illinois House Done")
nyh <- read.csv("/home/stats/hansenga/data/ss13hny.csv")
print("New York House Done")
pah <- read.csv("/home/stats/hansenga/data/ss13hpa.csv")
print("Pensylvania House Done")
txh <- read.csv("/home/stats/hansenga/data/ss13htx.csv")
print("Texas House Done")

nych   <- nyh[nyh$PUMA %in% newyork,]
lah    <- cah[cah$PUMA%in%losangeles,]
chih   <- ilh[ilh$PUMA%in%chicago,]
houh   <- txh[txh$PUMA%in%houston,]
phih   <- pah[pah$PUMA%in%phil,]
phoh   <- azh[azh$PUMA%in%phoe,]
sananh <- txh[txh$PUMA%in%sanan,]
sdh    <- cah[cah$PUMA%in%sandiego,]
dalh   <- txh[txh$PUMA%in%dallas,]
sjh    <- cah[cah$PUMA%in%sanjose,]

rm(azh,cah,ilh,nyh,pah,txh)


### Person
azp <- read.csv("/home/stats/hansenga/data/ss13paz.csv")
print("Arizona House Done")
cap <- read.csv("/home/stats/hansenga/data/ss13pca.csv")
print("California House Done")
ilp <- read.csv("/home/stats/hansenga/data/ss13pil.csv")
print("Illinois House Done")
nyp <- read.csv("/home/stats/hansenga/data/ss13pny.csv")
print("New York House Done")
pap <- read.csv("/home/stats/hansenga/data/ss13ppa.csv")
print("Pensylvania House Done")
txp <- read.csv("/home/stats/hansenga/data/ss13ptx.csv")
print("Texas House Done")

nycp   <- nyp[nyp$PUMA%in%newyork,]
lap    <- cap[cap$PUMA%in%losangeles,]
chip   <- ilp[ilp$PUMA%in%chicago,]
houp   <- txp[txp$PUMA%in%houston,]
phip   <- pap[pap$PUMA%in%phil,]
phop   <- azp[azp$PUMA%in%phoe,]
sananp <- txp[txp$PUMA%in%sanan,]
sdp    <- cap[cap$PUMA%in%sandiego,]
dalp   <- txp[txp$PUMA%in%dallas,]
sjp    <- cap[cap$PUMA%in%sanjose,]

rm(azp,cap,ilp,nyp,pap,txp)


## Merge city files

nyc   <- merge(nych,nycp,by="SERIALNO")
la    <- merge(lah,lap,by="SERIALNO")
chi   <- merge(chih,chip,by="SERIALNO")
hou   <- merge(houh,houp,by="SERIALNO")
phil  <- merge(phih,phip,by="SERIALNO")
phoe  <- merge(phoh,phop,by="SERIALNO")
sanan <- merge(sananh,sananp,by="SERIALNO")
sand  <- merge(sdh,sdp,by="SERIALNO")
dal   <- merge(dalh,dalp,by="SERIALNO")
sj    <- merge(sjh,sjp,by="SERIALNO")

## Merge all files

nyc$id   <- rep(1,nrow(nyc))
la$id    <- rep(2,nrow(la))
chi$id   <- rep(3,nrow(chi))
hou$id   <- rep(4,nrow(hou))
phil$id  <- rep(5,nrow(phil))
phoe$id  <- rep(6,nrow(phoe))
sanan$id <- rep(7,nrow(sanan))
sand$id  <- rep(8,nrow(sand))
dal$id   <- rep(9,nrow(dal))
sj$id    <- rep(10,nrow(sj))


commute <- rbind(nyc,la,chi,hou,phil,phoe,sanan,sand,dal,sj)

rm(nyc,la,chi,hou,phil,phoe,sanan,sand,dal,sj)
rm(nych,lah,chih,houh,philh,phoh,sananh,sdh,dalh,sjh)
rm(nycp,lap,chip,houp,philp,phop,sananp,sdp,dalp,sjp)

print(proc.time() - a)
rm(a)
