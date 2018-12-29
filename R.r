# 1.
# When you want to draw a heatmap-map, but there exists some strange lines after merging datasets.
# Solution: sort the merged data with "order" in map data.

# change the names of countries in original dataset
for(i in 1:1885){
  if(x$Country[i]==-0.09765){x$Country[i]="Australia"
  }else if(x$Country[i]==0.24923){x$Country[i]="Canada"
  }else if(x$Country[i]==-0.46841){x$Country[i]="New Zealand"
  }else if(x$Country[i]==0.21128){x$Country[i]="Ireland"
  }else if(x$Country[i]==0.96082){x$Country[i]="UK"
  }else if(x$Country[i]==-0.57009){x$Country[i]="USA"}
}

# get the data to present degree of colour
for(i in 1:1885){
  x$count[i] = sum(x[i,2:20]>0)}
  
# only leave columns "region" and "mean"(data)
x.df = x[,c(1,21)]
x.agg=aggregate(x.df[,2], list(x.df$region), mean)
colnames(x.agg) <- c("region","mean")

library(PBSmapping)
# install.packages("PBSmapping")

# get map data
world <- map_data('world')

# merge the data with map data
map.df <- merge(x.agg,world, by="region",all = T)

##### IMPORTANT!!!!
##### sort the data with "order" in map data
map.df <- map.df[order(map.df$order),]

# plot the heatmap-map
ggplot(map.df, aes(x=long,y=lat,group=group))+
  geom_polygon(aes(fill=mean),colour="grey")+
  scale_fill_gradient(low="#FFCC66",high="#FF9900",na.value="grey90")
# coord_map("polyconic") # make the plot can be shown in a ball shape

  
# 2.
# the lables on the x-axis is shown in the order of alphabet, but I want it in my order.
# Solution: add "level" option in ggplot function

levels = c('Left school before 16 years', 'Left school at 16 years', 
           'Left school at 17 years', 'Left school at 18 years', 
           'Some college or university, no certificate or degree', 
           'Professional certificate/ diploma', 'University degree', 
           'Masters degree', 'Doctorate degree')
  
# plot
ggplot(data=drug.edu, aes(x = factor(
  Education, level = levels), y=mean, group=1)) +
  geom_line(colour=col3)+
  geom_point(colour=col4)+
  theme_minimal()


# 3.
# Some colours I favourite in ggplot
  
plot(Music~year,type="l",lty=1,data = yeartable)
lines(ShortFilm~year,type="l",col="steelblue",lty=2,data = yeartable)
lines(Documentary~year,type="l",col="chartreuse4",lty=3,data = yeartable)
lines(Theatre~year,type="l",col="chocolate",lty=4,data = yeartable)
legend("topleft",cex=.6,c("Music","ShortFilm","Documentary","Theatre"),
       col=c("black","steelblue","chartreuse4","chocolate"),lty=1:6)
  

# 4.
# When you want to grid some plots, but their variable names are messed together.
# Solution: use option "rremove("x.text")" in "ggarrange" to the specific plot you want to remove.
  
ggarrange(p1, p2, p3+rremove("x.text"), p4+rremove("x.text"), p5, p6,
          # labels = c("A", "B", "C"),
          ncol = 3, nrow = 2)
