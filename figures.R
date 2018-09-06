## Graphs ##

png("z_qqplot_welfare.png",height=750,width=750)
qqnorm(combine$welfare>0)
qqline(combine$welfare>0)
dev.off()

png("z_hist_welfare.png",height=750,width=750)
hist(combine$welfare)
hist(combine$welfare)
dev.off()

print(summary(combine$welfare))
print(summary(combine$welfare[which(combine$welfare>0)]))