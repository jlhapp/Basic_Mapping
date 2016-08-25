#Import two Shapefiles, view, and merge them together

library(rgdal)
#Import shapefiles using readOGR from rgdal package
NC = readOGR(dsn = "data/NC.shp", layer = "NC")
SC = readOGR(dsn = "data/SC.shp", layer = "SC")

#View NC in "Viewer"
plot(NC)

library(raster)
library(rgeos)
#Merge NC and SC shapefiles together using Raster library
Carolinas <- union(NC, SC)

#View NC and SC merged together
plot(Carolinas)
