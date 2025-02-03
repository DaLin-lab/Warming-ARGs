library(ggplot2)
library(RColorBrewer)

regression<-read.table('.txt',header = T)    
gg3<-ggplot(data=regression)+geom_point(aes(warming,ARGs),fill='#D89A97',colour='#4C0611',size=1,shape=21,alpha=0.2)+
  geom_smooth(aes(warming,ARGs),size=0.8,method = 'lm',formula = y~poly(x,2),span=0.4,se = TRUE,colour='#231815',alpha=0.2)+
  geom_point(aes(warming,ARGs),fill='#D89A97',colour='#4C0611',size=4,shape=21,alpha=0.8)+
  geom_smooth(aes(warming,ARGs),size=0.8,method = 'lm',formula = y~poly(x),span=0.4,se = TRUE,colour='#C0BFBE',fill='#C0BFBE',alpha=0.2)
gg3