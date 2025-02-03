library(randomForest)
library(rfPermute)
library(tidyverse)
library(randomForest)
library(rfUtilities)
library(rfPermute)

data1<-read.csv(".csv",row.names=1)
richness_rf <- randomForest(ARG~., data= data1,importance=TRUE,proximity=TRUE)
richness_rf
set.seed(123)
richness_perm <- rf.significance(richness_rf, data1[,-1], nperm=99, ntree=101)
richness_perm
richness_rfP<- rfPermute(ARG~., data = data1, ntree = 1000,na.action = na.omit, nrep = 500,num.cores = 1)
                      

richness_dat <- importance(richness_rfP, sort.by = NULL, decreasing = TRUE)

richness_dat %>%
  
  as_tibble(rownames = "names") %>%
  
  data.frame() %>%
  
  mutate(label = if_else(X.IncMSE.pval < 0.001,"***",
                         
                         if_else(X.IncMSE.pval <0.01,"**",
                                 
                                 if_else(X.IncMSE.pval<0.05,"*","ns"))),
         
         X.IncMSE = as.numeric(X.IncMSE)) %>%
  
  arrange(X.IncMSE) %>%
  
  mutate(group = if_else(label=="ns","In_sig","Sig"),
         
         names = forcats::fct_inorder(names)) %>%
  
  ggplot(aes(x = names, y = X.IncMSE))+
  
  geom_bar(aes(fill = group),stat = "identity")+
  
  geom_text(aes(y = X.IncMSE + 1,label = label))+
  
  labs(x = "", y = "%IncMSE")+
  
  coord_flip()                  
write.csv(richness_dat,'.csv')

