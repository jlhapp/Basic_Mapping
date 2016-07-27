###Basics of mapping using shapefiles, csv files with address information, 
###and geojson file.

library(rgdal)
library(sp)
library(ggmap)

############################################################################
###########################Shapefiles########################################
####1. Open a shapefile using rgdal
#Name a variable "Marine" and use "readOGR expression.  dsn = data source
#name and should be set to your folder with the shapefile.  layer = the 
#name of the layer.
Marine <- readOGR(dsn = "D:/LearnR/BasicMapping/WeatherStations.shp", layer = "WeatherStations")

#Read "Marine's" projection using proj4string
proj4string(Marine)

#Remove a projection and then set a new projection
proj4string(Marine) <- NA_character_ #remove CRS information from Marine
proj4string(Marine) <- CRS("+init=epsg:32119") #set projection to NAD83/NC




####2. Open a shapefile using maptools
#A. POLYGONS
library(maptools)
#Open states shapefile (polygons)
#Points readShapePoints()
#Lines readShapeLines()
states <- readShapePoly("D:\\DesktopStuff\\R\\Shapefiles\\UnitedStates.shp")

#Gets a summary of the data.  Use summary(name of shapefile)
summary(states)

#readShapePoly will not read the projection file.  You will get a result
#of [1] NA if you do not set the projection after import.
print(proj4string(states))

#To set a projection, use the following code. Get from QGIS
proj4string(states) <- "+proj=utm +zone=14 +datum=WGS84 +units=m"

#OR
# to change to correct projection:
shpData <- spTransform(states,
                       CRS("+proj=longlat +datum=WGS84")) 

#Verify the projection is set
print(proj4string(states))



#Make a simple map of the states.  Plot will display in the lower
#right-hand corner (next to files, package, etc.)
plot(states, border="black")
###########################Shapefiles########################################
############################################################################



############################################################################
#######################Convert shapefile to GeoJSON############################
#Can convert a shapefile to a GeoJSON file using QGIS.  Right click on layer
#and select Save As.  Change the file type to GeoJSON.

#For R script:
#Use the shapefile of weather stations 
library(tmap) # to read shapefile
library(geojsonio) # to write geojson

#Name variable shp and use read_shape 
shp = read_shape("D:/LearnR/BasicMapping/WeatherStations.shp")
#plot the shp data
qtm(shp)
#use the geojson_write expression followed by ([current file extension],
#file = "[file path]")
geojson_write(shp, file = "D:/tmp/shp.geojson")
#######################Convert shapefile to GeoJSON############################
############################################################################

