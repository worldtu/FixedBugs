## 1.
### When you want to draw a heatmap-map, but there exists some strange lines after merging datasets.
### Solution: sort the merged data with "order" in map data.

```{r}
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
```
