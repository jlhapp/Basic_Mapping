#Basics of mapping rasters.  
#-Use the Raster() function to import a single band raster.  Result will be "Formal class Raster Layer" 
#-the stack() function for multiband rasters.  Result will be "Formal class RasterStacK"
#-Use readGDAL() function.  Result will be "SpatialGridDataFrame"

library(rgdal)
library(sp)
library(ggmap)

if(!require(raster)) install.packages("raster")

############################################################################
############################Rasters########################################
install.packages("raster")
library(raster)

#Reference where the data is stored.  Raster returns a RasterLayer object
#and is defined in the raster package.  Visualize with plot()
#climate <- raster("D:/DesktopStuff/R/Shapefiles/precipann_r_nc1.tif")
climate <- raster("data/precipann_r_nc1.tif")

#readGDAL returns a SpatialGridDataFrame and is defined by the sp package.
#Visualize with spplot()
#climate2 <- readGDAL("D:/DesktopStuff/R/Shapefiles/precipann_r_nc1.tif")
climate2 <- readGDAL("data/precipann_r_nc1.tif")

#readGDAL can read ERDAS Imagine file
Elev <- readGDAL("ned3m.img") 


#View the projection for the raster
proj4string(climate2)

#Map the raster with the appropriate expression.
plot(climate3)
spplot(climate2)



##TO SET A NEW PROJECTION FOR A RASTER
#Import a raster
#climate3 <- raster("D:/DesktopStuff/R/Shapefiles/precipann_r_nc12.tif")
climate3 <- raster("data/precipann_r_nc12.tif")

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


#Import precipitation raster for each month
PrecipJan <- raster("data/precipjan_r_nc1.tif")
PrecipFeb <- raster("data/precipfeb_r_nc1.tif")
PrecipMar <- raster("data/precipmar_r_nc1.tif")
PrecipApr <- raster("data/precipapr_r_nc1.tif")
PrecipMay <- raster("data/precipmay_r_nc1.tif")
PrecipJun <- raster("data/precipjun_r_nc1.tif")
PrecipJuly <- raster("data/precipjul_r_nc1.tif")
PrecipAug <- raster("data/precipaug_r_nc1.tif")
PrecipSept <- raster("data/precipsep_r_nc1.tif")
PrecipOct <- raster("data/precipoct_r_nc1.tif")
PrecipNov <- raster("data/precipnov_r_nc1.tif")
PrecipDec <- raster("data/precipdec_r_nc1.tif")


#Use stack() function and combine all of the rasters.  Use object$ and you will 
#get a list of all the raster.  You can then use plot() to view all rasters in stack
rstack <- stack("data/precipnov_r_nc1.tif", "data/precipdec_r_nc1.tif")


plot(rstack$precipdec_r_nc1)

#Set animation to rasters using the raster stack object
animate(rstack)
