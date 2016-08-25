###Basics of mapping using shapefiles, csv files with address information, 
###and geojson file.

library(rgdal)
library(sp)
library(ggmap)

############################################################################
###########################csv files#########################################

#Open a csv file named UNC
UNC <- read.csv("data/UNC.csv")

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
map <- get_map((gc), zoom = 7)
#Set the bounding box using the geocoded map
(bb <- attr(map, "bb2"))
(bbox <- bb2bbox (bb2))

#Get the Stamenmap using the bounding box.
stamMap <- get_stamenmap(bbox)

#use the created map in ggmap and add the UNC table using the "geo_point"
#expression.  You must have (data = [your table], aes(x=[the x column name],
#y=[the y column name in your table]), color="[color]")
ggmap(map) + geom_point(data = UNC, aes(x=X, y=Y), color="red")

###########################csv files#########################################
############################################################################



