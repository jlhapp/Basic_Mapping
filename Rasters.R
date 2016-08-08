###Basics of mapping using shapefiles, csv files with address information, 
###and geojson file.

library(rgdal)
library(sp)
library(ggmap)


############################################################################
############################Rasters########################################
install.packages("raster")
library(raster)

#Reference where the data is stored.  Raster returns a RasterLayer object
#and is defined in the raster package.  Visualize with plot()
climate <- raster("D:/DesktopStuff/R/Shapefiles/precipann_r_nc1.tif")

#readGDAL returns a SpatialGridDataFrame and is defined by the sp package.
#Visualize with spplot()
climate2 <- readGDAL("D:/DesktopStuff/R/Shapefiles/precipann_r_nc1.tif")
#readGDAL can read ERDAS Imagine file
Elev <- readGDAL("ned3m.img") 


#View the projection for the raster
proj4string(climate2)

#Map the raster with the appropriate expression.
plot(climate3)
spplot(climate2)



##TO SET A NEW PROJECTION FOR A RASTER
#Import a raster
climate3 <- raster("D:/DesktopStuff/R/Shapefiles/precipann_r_nc12.tif")

#To view rojection information
projection(climate3)

#Create a variable and write the new projection inforamtion
Proj2 <- "+proj=laea +lat_1=52 +lon_0=-10 +ellps=GRS80"

#Transorm projection to another coordinate system using the projectRaster
#function
RasterProj <- projectRaster(climate3, crs = Proj2, method = 'bilinear')

#Verify the projection is changed using the projection() function
projection(RasterProj)
###########################Rasters########################################
############################################################################
