library(ggplot2)
library(tidyterra)
MAT<-rast("wc2.1_30s_bio_1.tif")
p3<-ggplot() +   
  geom_spatraster(data=MAT)+    
  scale_fill_viridis_c(option = "plasma",name='MAT(℃)',na.value = 'transparent')+    
  coord_sf(expand = FALSE)+     
  theme_minimal()+ 
  theme(legend.position="left",legend.key.size = unit(0.4, "cm"))
p3
fig1a.dat<-read_excel("global data distribution.xlsx",
                      sheet = "Fig1")
fig1a.dat
p3+
  geom_point(data=fig1a.dat,aes(x=Longitude,y=Latitude,color=sufferedECE,size=number))+scale_size(range=c(1,5))+
  scale_color_manual(values = c("Passive warming"="#F7D2BE",
                                "Active warming"="#C9D7EE"),
                     name="EWEs")+
  guides(color=guide_legend(override.aes = list(size=5)))+
  theme(legend.position = c(0.1,0.5))
