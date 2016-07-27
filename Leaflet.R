
library(leaflet)
library(jsonlite)
library(shiny)
library(rgdal)

############################################################################
#############################Hurricane Leaflet##############################
#Set the name "geojson" to a geojson file located on my D drive.
Cat1 <- readLines("D:\\LearnR\\TryGEojson\\Cat1.geojson", warn = FALSE) %>%
  paste(collapse = "\n") %>%
  fromJSON(simplifyVector = FALSE)

#Set the name "geojson" to a geojson file located on my D drive.  Cat2 does
#not have as much data as Cat1
Cat2 <- readLines("D:\\LearnR\\TryGEojson\\Cat2.geojson", warn = FALSE) %>%
  paste(collapse = "\n") %>%
  fromJSON(simplifyVector = FALSE)

#To map the GeoJSON file to a specific extent, you'll first need to name a
#variable.  Add leaft() %>% and then setView and specify the lat/long. Set 
#the zoom level on a 1-17 scale. 1 = full zoom out, 17 = full zoom in
viewmap <- leaflet() %>% setView(lng = -76.0589, lat = 34.9601, zoom = 7) 
viewmap %>% addGeoJSON(Cat1) %>% addTiles()  

#############################Hurricane Leaflet##############################
############################################################################






############################################################################
#######################Leaflet with calculation#############################
Triangle <- readLines("D:\\LearnR\\TryGEojson\\Triangle.geojson", warn = FALSE) %>%
  paste(collapse = "\n") %>%
  fromJSON(simplifyVector = FALSE)

#Set the style for the Triangle geojson file.
Triangle$style = list(
  weight = 1,
  color = "#555555",     #Green
  opacity = 1,
  fillOpacity = 0.8
)

#Name variable "tot_population." 
tot_population <- sapply(Triangle$features, function(feat){
  feat$properties$DP0010001
})

#Name variable "whi_population." 
whi_population <- sapply(Triangle$features, function(feat){
  feat$properties$DP0010002
})

#Name variable "perc". 
perc <- colorQuantile("Greens", whi_population/tot_population)

#######
Triangle$features <- lapply(Triangle$features, function(feat) {
  feat$properties$style <- list(
    fillColor = perc(
      feat$properties$DP0010002 / max(1, feat$properties$DP0010001)
    )
  )
  feat
})

#To map the GeoJSON file to a specific extent, you'll first need to name a
#variable.  Add leaft() %>% and then setView and specify the lat/long. Set 
#the zoom level on a 1-17 scale. 1 = full zoom out, 17 = full zoom in
viewmap2 <- leaflet() %>% setView(lng = -78.2589, lat = 35.9601, zoom = 8) 
viewmap2 %>% addGeoJSON(Triangle) %>% addTiles()

#Can also map with world extent
leaflet() %>% addGeoJSON(Triangle) %>% addTiles()

#######################Leaflet with calculation#############################
############################################################################




###To save online, click Export, and Save as Webpage...it'll install some packages and save html
###file to your project directory.



############################################################################
############################################################################
###########################April 2011 Tornado Outbreak#######################

##############CONVERT TORNADOES SHAPEFILE TO GEOJSON FILE##################
library(tmap) # to read shapefile
library(geojsonio) # to write geojson

#Name variable shp and use read_shape 
shp = read_shape("D:/LearnR/BasicMapping/April2011.shp")
#plot the shp data
qtm(shp)
#use the geojson_write expression followed by ([current file extension],
#file = "[file path] with the name of the geojson you want")
geojson_write(shp, file = "D:/LearnR/BasicMapping/AprilTornado.geojson")
##############CONVERT TORNADOES SHAPEFILE TO GEOJSON FILE##################

##############################LEAFLET#####################################
#Set the name "geojson" to the Tornadoes geojson
AprilTorn <- readLines("D:\\LearnR\\BasicMapping\\AprilTornado.geojson", warn = FALSE) %>%
  paste(collapse = "\n") %>%
  fromJSON(simplifyVector = FALSE)

#To map the GeoJSON file to a specific extent, you'll first need to name a
#variable.  Add leaft() %>% and then setView and specify the lat/long. Set 
#the zoom level on a 1-17 scale. 1 = full zoom out, 17 = full zoom in
viewmap <- leaflet() %>% setView(lng = -89.0589, lat = 35.9601, zoom = 5) 
viewmap %>% addGeoJSON(AprilTorn) %>% addTiles()

##Categorize the lines by magnitude of the tornado
Magnitude <- subset(AprilTorn, AprilTorn$Name %in% c("EF4","EF5"))

###########################April 2011 Tornado Outbreak#######################
############################################################################
############################################################################




############################################################################
################################RASTER LEAFLET###########################
#import raster library
library(raster)

#Name variable climate and specify the location of the raster using raster
#expression
climate <- raster("D:/DesktopStuff/R/Shapefiles/precipann_r_nc1.tif")

#Name variable "pal" and write colorNumeric expression.  c = choices,
#specify "values" as teh raster variable
pal <- colorNumeric(c("#0C2C84", "#41B6C4", "#FFFFCC"), values(climate),
                    na.color = "transparent")

#add leaflet and tiles
leaflet() %>% addTiles() %>%
  #add the raster image.  After the first parantheses, write the raster
  #variable, then colors = [the color palette(i.e. pal)] and opacity
  addRasterImage(climate, colors = pal, opacity = 0.8) %>%
  #add the legend and title
  addLegend(pal = pal, values = values(climate),
            title = "Annual Rain")
################################RASTER LEAFLET###########################
############################################################################



