#Thsi document has no code.  Rather it serves as a basic understanding
#of R with the primary goal being mapping.  Information in this document
#will also reference other R documents that I have with the actual code.

#BASIC OPERATORS
#maggrittr operator (%>%).  Pros of using:
#1. Easier to add steps anywhere in operation
#2. Structure operation left to right instead of inside out.
#
#
#
#

#############################################################################
###############################IMPORT SHAPEFILE##################################
#IMPORT SHAPEFILE
#Use rgdal package and the readOGR function.  This will read the projection file.
#[variable name]<- readOGR(dsn = "folder location with .shp extension", layer ="name only")
#
#
#Use maptools package and readShapePoly function.  This will NOT read the projection 
#file and you will need to set the projection.
#[variable name]<- readShapePoly("folder location with .shp extension")
#
###############################IMPORT SHAPEFILE##################################
#############################################################################




############################################################################
###############################VIEW QUICK MAP###############################
#VIEW MAP
#Use plot() function
#plot() will display shapefile with no background
#
#If a background map is needed, use ggmap
#
#
#
#
#
#
###############################VIEW QUICK MAP###############################
#############################################################################



#############################################################################
###############################PROJECTION##################################
#VIEW PROJECTION INFORMATION
#Once the shapefile is imported use thh proj4string([variable]) fucntion
#or print(proj4string([variable])) to read the projection.
#
#If there is no projection or since readShapePoly will not read the projection file, 
#you will get a result of [1] NA.
#
#THREE WAYS TO SET PROJECTION
#1. Use proj4string([variable]) <- "+proj=utm +zone=14 +datum=WGS84 +units=m" function
#2. Use proj4string([variable]) <- CRS(+init=epsg:32119") function
#3. Or create a new variable using spTransform function.  For example: 
#   shpData <- spTransform(states, CRS("+proj=longlat +datum=WGS84")) 
#
#**You can't use the third way if no projection is set...you'd need to use the
#first method.**
#
#
#You can also remove a projection using proj4string([variable]) <- NA_character_
###############################PROJECTION##################################
#############################################################################



############################################################################
##############################DISPLAY XY DATA#####################################
#ADD XY INFORMATION FROM CSV FILE
#You need to have x,y coordinates in the csv file, each as separate columns.
#Import csv into R using read.csv("file location and extension")
#To view all of the data and column heading use print([name of variable])
#To view the first three rows of data use head([name of variable], 3)
#
#Use ggmap to display x,y coordinates on top of map
#1. Geocode the center of a map.  variable <- geocode("North Carolina")
#2. Map the geocoded point and set zoom level.  variable2 <- get_map((variable), zoom = 7)
#3. Set bounding box using goeocded map
#4. Get the Stamenmap using the bounding box
#5. #use the created map in ggmap and add the UNC table using the "geo_point"
#expression.  You must have (data = [your table], aes(x=[the x column name],
#y=[the y column name in your table]), color="[color]")
#
#Code on "csv.R" script
#
##############################DISPLAY XY DATA#####################################
#############################################################################



############################################################################
##########################RASTER DATA######################################
#RASTER DATA
#Use raster library or sp package to import data
#1. RASTER LIBRARY
#   a. Using the raster package will return a RasterLayout object and you will
#      need to visualize using the plot() function
#   b. To import name a variable and use raster() function
#      variable <- raster("folder location.tif")
#   c. To view the map with a legend, use plot()
#      plot(variable)
#
#2. SP PACKAGE
#   a. using the SP package will return a SpatialGridDataFrame and you will
#      need to visualize using the spplot() function.
#   b. To import name a variable and use readGDAL() function
#      variable <- readGDAL("folder location.tif")
#   c. To view the map with a legend, use spplot()
#      spplot(variable)
#
#Code on "Rasters.R" script
#
#
#RASTERS IN LEAFLET
#Use raster() to import layer
#You need to specify color scheme use <- colorNumeric function.  Name variable 'pal'
#use <- operator and colorNumeric funtion.  Then specify color scheme choices using
#"c()", set values to the raster variable and any part of the raster that has no
#value to transparent.  For example:
#
#pal <- colorNumeric(c("#0C2C84", "#41B6C4", "#FFFFCC"), values(climate),
#na.color = "transparent")
#
#Now that there's a variable named pal for the color scheme we can add this to 
#leaflet.  First add leaflet() and  tiles() separated by %>% operator.  Then 
#add the raster using the "addRasterImage()."  Within addRasterImage, you'll
#need to first specify the data, colors = [variable from color scheme above],
#and opacity.  Then you can add legend if you'd like.  For example:
#
#leaflet() %>% addTiles() %>%
#addRasterImage(climate, colors = pal, opacity = 0.8) %>%
  #addLegend(pal = pal, values = values(climate), title = "Annual Rain")
###########################RASTER DATA######################################
#############################################################################



############################################################################
###############################GEOJSON FILES###############################
#GeoJSON files
#GeoJSON is a JavaScript object with geographic data.  Also, leaflet is
#designed to work natively with GeoJSON.
#
#Can convert a shapefile to a GeoJSON file using QGIS.  Right click on layer
#and select Save As.  Change the file type to GeoJSON.
#
#For R script, load tmap and geojsonio libraries
#1. Name variable and use read_shape.  For example:
#   shp = read_shape("file location.shp")
#2. Plot shp data using qtm expression.
#   qtm(shp)
#3. Use the geojson_write expression followed by ([current file extension],
#   file = "[file path]").  For example
#   geojson_write(shp, file = "D:/tmp/shp.geojson")
#
#To import GeoJSON files use readLines function.
###############################GEOJSON FILES###############################
#############################################################################





#############################################################################
#############################LEAFLET BASICS##################################
#MAPPING IN LEAFLET (This section covers shapefiles; for rasters, see RASTER DATA)
##There are many ways to display leaflet map.  If you want a simple map:
#leaflet() %>% addPolylines(data = [variable])
#
#This will have no tiles, view set, but a leaflet map will appear
#
#
#
#If you want a customized map, create a new variable and set leaflet(), setView(),
#and tiles.  You'll want the basics for this portion.  For example:
#MyMap <- leaflet() %>% setView(lng = -78.2589, lat = 35.9601, zoom = 8)  %>% addTiles()
#
#Now all you need to do is write MyMap follow by the maggitr operator and add
#data (polygons, lines) that you need.  For example:
#MyMap %>% addPolylines(data = April11_1) 
#
#
#Instead of using addPolylines, you can use the following to add various types
#of data:
#Add lines by using addPolylines()
#Add polygons by using addPolygons()
#Add geojson by using addGeoJSON()
#add raster by using addRasterImage()
#Add points by using addMarker()
#
##############################LEAFLET BASICS##################################
#############################################################################



#############################################################################
#############################LEAFLET IN SHINY###############################
#LEAFLET AND SHINY
#When using with shiny app, you need "leafletOutput" in the ui.R file and
#"renderLeaflet() in the server.R file.  You need leafletProxy() function 
#to modify a map that's already running in a page.
#
#
#
#
#
#
#
#
#
#
#
#
#
#
##############################LEAFLET IN SHINY###############################
##############################################################################





#############################################################################
#############################BASICS SHP PROCEDURES###############################
#MERGE
#Use raster library and the union function.  For example
#newvariable <- union([variable1, variable2]) 
#
#
#
#
#
#
#CLIP
#
#
#
#
#
#
#
##############################LEAFLET BASICS##################################
#############################################################################


#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
