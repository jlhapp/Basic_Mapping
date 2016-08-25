###Basics of mapping using shapefiles, csv files with address information, 
###and geojson file.

library(rgdal)
library(sp)
library(ggmap)
library(ggplot2)

############################################################################
###########################Shapefiles########################################
####1. Open a shapefile using rgdal
#Name a variable "Marine" and use "readOGR expression.  dsn = data source
#name and should be set to your folder with the shapefile.  layer = the 
#name of the layer.
    #A.  Absolute path.  Define exactly the location of the shapefile
    Marine <- readOGR(dsn = "D:/LearnR/BasicMapping/WeatherStations.shp", layer = "WeatherStations")
    #B.  Relative path.  If you have a folder named data within your project, all you have
    #    to write is "data/SHAPEFILE"
    Marine2 <- readOGR(dsn = "data/WeatherStations.shp", layer = "WeatherStations")

#Read "Marine's" projection using proj4string
proj4string(Marine)

#Remove a projection and then set a new projection
proj4string(Marine) <- NA_character_ #remove CRS information from Marine
proj4string(Marine) <- CRS("+init=epsg:32119") #set projection to NAD83/NC

#View the entire attribute table of the shapefile
attributes(Marine)

#Create another variable by extracting one column. First name a variable
#followed by <-.  Then use the shapefile variable name followed by 
#"@data$".  You will then see a drop-down of the column names.
SeaLevel <- Marine@data$Sea_Level
summary(SeaLevel)

#To quickly change the projection information use the following code.  
#However, spTransform should be used for reprojection.
proj4string(Marine) <-CRS("+proj=utm +zone=10 +datum=WGS84")




####2. Open a shapefile using maptools
#A. POLYGONS
library(maptools)
#Open states shapefile (polygons)
#Points readShapePoints()
#Lines readShapeLines()
states <- readShapePoly("data\\UnitedStates.shp")

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
print(proj4string(shpData))


#Make a simple map of the states.  Plot will display in the lower
#right-hand corner (next to files, package, etc.)
plot(states, border="black")
###########################Shapefiles########################################
############################################################################

