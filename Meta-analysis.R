
###################################Meta-analysis####################
library(metafor)

#set working directory
setwd("")

#read-in data
data1 <- read.csv(".csv",header = T)
summary(data1)

####Select type####
data2 <- subset(data1,ID == "")

#calculate effect sizes-log response ration (ROM)
RR <- escalc(measure="ROM",m1i=Tm, m2i=Cm,sd1i=Tsd,sd2i=Csd,n1i=Tn,n2i=Cn, data=data1,var.names=c("LRR","LRR_var"))
View(RR)
write.csv(RR,".csv", row.names = FALSE, quote = FALSE)

#calculate overall responses
rem <- rma(LRR,LRR_var,data = RR,method="DL")
summary(rem)

#egger's test and funnel plot
regtest(rem)
funnel(rem, xlab="Effect size")
