#### INDP and OCCP Recode ####

attach(train)
# INDP Recode
train$indp[INDP>=1 & INDP<=2]   <- 1 #AGR
train$indp[INDP>=3 & INDP<=4]   <- 2 #EXT
train$indp[INDP>=5 & INDP<=6]   <- 3 #UTL
train$indp[INDP==7]             <- 4 #CON
train$indp[INDP>=10 & INDP<=39] <- 5 #MFG
train$indp[INDP>=40 & INDP<=45] <- 6 #WHL
train$indp[INDP>=46 & INDP<=57] <- 7 #RET
train$indp[INDP>=60 & INDP<=63] <- 8 #TRN
train$indp[INDP>=64 & INDP<=67] <- 9 #INF
train$indp[INDP>=68 & INDP<=71] <- 10 #FIN
train$indp[INDP>=72 & INDP<=77] <- 11 #PRF
train$indp[INDP>=78]            <- 12 #EDU
train$indp[INDP>=79 & INDP<=82] <- 13 #MED
train$indp[INDP>=83 & INDP<=84] <- 14 #SCA
train$indp[INDP>=85 & INDP<=86] <- 15 #ENT
train$indp[INDP>=87 & INDP<=92] <- 16 #SRV
train$indp[INDP>=93 & INDP<=95] <- 17 #ADM
train$indp[INDP>=96 & INDP<=98] <- 18 #MIL
train$indp[INDP==99]            <- 0 #Unemployed
train$indp[INDP==0]             <- 0 #Unemployed

# OCCP Recode
train$occp[OCCP>=0 & OCCP<=4]   <- 1 #MGR
train$occp[OCCP>=5 & OCCP<=7]   <- 2 #BUS
train$occp[OCCP>=8 & OCCP<=9]   <- 3 #FIN
train$occp[OCCP>=10 & OCCP<=12] <- 4 #CMM
train$occp[OCCP>=13 & OCCP<=15] <- 5 #ENG
train$occp[OCCP>=16 & OCCP<=19] <- 6 #SCI
train$occp[OCCP==20]            <- 7 #CMS
train$occp[OCCP==21]            <- 8 #LGL
train$occp[OCCP>=22 & OCCP<=25] <- 9 #EDU
train$occp[OCCP>=26 & OCCP<=29] <- 10 #ENT
train$occp[OCCP>=30 & OCCP<=35] <- 11 #MED
train$occp[OCCP==36]            <- 12 #HLS
train$occp[OCCP>=37 & OCCP<=39] <- 13 #PRT
train$occp[OCCP>=40 & OCCP<=41] <- 14 #EAT
train$occp[OCCP==42]            <- 15 #CLN
train$occp[OCCP>=43 & OCCP<=46] <- 16 #PRS
train$occp[OCCP>=47 & OCCP<=49] <- 17 #SAL
train$occp[OCCP>=50 & OCCP<=59] <- 18 #OFF
train$occp[OCCP>=60 & OCCP<=61] <- 19 #FFF
train$occp[OCCP>=62 & OCCP<=67] <- 20 #CON
train$occp[OCCP>=68 & OCCP<=69] <- 21 #EXT
train$occp[OCCP>=70 & OCCP<=76] <- 22 #RPR
train$occp[OCCP>=77 & OCCP<=89] <- 23 #PRD
train$occp[OCCP>=90 & OCCP<=97] <- 24 #TRN
train$occp[OCCP==98]            <- 25
train$occp[OCCP==99]            <- 0
train$occp[OCCP==-1]            <- 0

detach(train)