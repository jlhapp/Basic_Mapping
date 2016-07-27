###Basics of mapping using shapefiles, csv files with address information, 
###and geojson file.

library(rgdal)
library(sp)
library(ggmap)


############################################################################
###########################csv files#########################################

#Open a csv file named UNC
UNC <- read.csv("D:/LearnR/BasicMapping/UNC.csv")

#View UNC columns and data
print(UNC)

#To find out the x,y min/max of your data use the str expression
str(UNC)

#Display the first three rows of the table
head(UNC, 3)


########Plot x,y coordinates using ggmap
#Grab the center of a map and compute its bounding box.  
#first geocode the center location
gc<- geocode("Durham, North Carolina")
#then map the geocoded point
map <- get_map(gc)
#Set the bounding box using the geocoded map
(bb <- attr(map, "bb2"))
(bbox <- bb2bbox (bb2))

#Get the Stamenmap using the bounding box.
stamMap <- get_stamenmap(bbox)

#use the created map in ggmap and add the UNC table using the "geo_point"
#expression.  You must have (data = [your table], aes(x=[the x column name],
#y=[the y column name in your table]), color="[color]")
ggmap(map) + geom_point(data = UNC, aes(x=X, y=Y), color="red")
########Plot x,y coordinates using ggmap




###Plot x,y coordinates using ggplot
library(ggplot2)

#Can map x,y coordinates by themselves in two ways.
ggplot() + geom_point(data = UNC, aes(x=X, y=Y), color="red")

#OR name a variable and use plot function
map <- ggplot() + geom_point(data = UNC, aes(x=X, y=Y), color="red")
plot(map)
###Plot x,y coordinates using ggplot



###Map x,y coordinates on top of shapefile you have
#map census tract shapefile of North Carolina
Tracts <- readOGR(dsn = "D:/LearnR/BasicMapping/NC_Tracts.shp", layer = "NC_Tracts")
plot(Tracts)

###Map x,y coordinates on top of shapefile you have

###########################csv files#########################################
############################################################################



