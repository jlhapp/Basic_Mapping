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

#Convert to GeoJSON file



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
###########################csv files#########################################

#Open a csv file named UNC
UNC <- read.csv("D:/LearnR/BasicMapping/UNC.csv")

#View UNC columns and data
print(UNC)

#To find out the x,y min/max of your data use the str expression
str(UNC)

#Display the first three rows of the table
head(UNC, 3)

Tracts <- readOGR(dsn = "D:/LearnR/BasicMapping/NC_Tracts.shp", layer = "NC_Tracts")
plot(Tracts)
gg



#######Create a simple map
points(UNC$X, UNC$Y)

install.packages("ggplot")
library(ggplot2)
ggplot() + geom_point(data = UNC, aes(x=X, y=Y), color="red")



###########################csv files#########################################
############################################################################



############################################################################
###########################GeoJSON files#####################################

###########################GeoJSON files#####################################
############################################################################



############################################################################
############################Rasters########################################
Elev <- readGDAL("ned3m.img") # ERDAS Imagine .img file 

install.packages("raster")
library(raster)

#Reference where the data is stored.  Raster returns a RasterLayer object
#and is defined in the raster package.  Visualize with plot()
climate <- raster("D:/DesktopStuff/R/Shapefiles/precipann_r_nc1.tif")

#readGDAL returns a SpatialGridDataFrame and is defined by the sp package.
#Visualize with spplot()
climate2 <- readGDAL("D:/DesktopStuff/R/Shapefiles/precipann_r_nc1.tif")

#View the projection for the raster
proj4string(climate2)

#Map the raster with the appropriate expression.
plot(climate)
spplot(climate2)

###########################3Rasters########################################
############################################################################





#Creates a new table with Longitude and Latitude as column names
coord <- cbind(UNC$Longitude, UNC$Latitude)