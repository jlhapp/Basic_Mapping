#This script takes a csv file with x, y coordinates and converts the rows
#into points on a map.

library(rgdal)
library(maptools)
library(leaflet)

#read the csv file
UNC <- read.csv("D:/LearnR/BasicMapping/UNC.csv")

#Use the cbind function to combine matrices (the latitude and longitude columns) together
coords <- cbind(UNC$longitude, UNC$latitude)

#Create a spatial points data frame and define the projection (WGS 84)
sp_NC <- SpatialPointsDataFrame(coords = coords, data = UNC, proj4string = CRS("+proj=longlat +datum=WGS84"))

#Use the spTransform to project the sp_NC variable to NAD83 UTM Zone 17
sp_NC_proj <- spTransform(sp_NC, CRS("+init=epsg:26917"))

#Add leaflet and then add markers.  
leaflet() %>%
  addMarkers(data = UNC, lat = ~ latitude, lng = ~ longitude,
             popup = UNC$School) %>% addTiles()