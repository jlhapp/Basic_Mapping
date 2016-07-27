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