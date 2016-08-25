
library(leaflet)
library(jsonlite)
library(shiny)
library(rgdal)

#Add lines by using addPolylines()
#Add polygons by using addPolygons()
#Add geojson by using addGeoJSON()
#add raster by using addRasterImage()
#Add points by using addMarker()
#
#When using with shiny app, you need "leafletOutput" in the ui.R file and
#"renderLeaflet() in the server.R file.


############################################################################
#############################Hurricane Leaflet##############################
#Set the name "geojson" to a geojson file located on my D drive.
Cat1 <- readLines("data\\Cat1.geojson", warn = FALSE) %>%
  paste(collapse = "\n") %>%
  fromJSON(simplifyVector = FALSE)

#Set the name "geojson" to a geojson file located on my D drive.  Cat2 does
#not have as much data as Cat1
Cat2 <- readLines("data\\Cat2.geojson", warn = FALSE) %>%
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
######################Categorized Torando line Leaflet################################

#Map lines from a shapefile
Tornado11 = readOGR(dsn = "data/April2011.shp", layer = "April2011")

#Create Spatial Data Frame for Tornadoes with a magnitude 5.  First create a
#variable, then use subset expression.  Reference the shapefile variable you
#created in R and then use @data to access the table fields.
Mag5 <- subset(Tornado11, Tornado11@data$MagNum >4)


#Add lines from shapefile with all one color
leaflet() %>% addTiles() %>%
  addPolylines(data = Tornado11, col = "blue")


#Cateogrize lines by tornado magnitude - to color field/column data, you 
#first need to create a color function (typically called pal).  There are 3
#color functions for numeric data (colorNumeric, colorBin, and colorQuantile)
#and one for categorical (colorFactor). from https://rstudio.github.io/leaflet/colors.html
#create pal variable and use colorNumeric expression since the field being
#used is an integer
pal<-colorNumeric(
  #specify the color scheme you want to use
  palette = "YlOrRd",
  #use domain = and specify the shapefile and field
  domain = Tornado11$MagNum
)


#create leaflet and include line shapefile
leaflet(Tornado11) %>% addTiles() %>%
  #add polylines
  addPolylines(
    #denote the "pal" variable created above and reference the shapefile and
    #field again.  Use "~paste()"function to add custom field/column info
    stroke = TRUE, color = ~pal(Tornado11$MagNum), popup = ~paste("Magnitude: ", MagNum)
  )
######################Categorized Torando line Leaflet################################
############################################################################




############################################################################
##############################Points###############################
library(shiny)
library(leaflet)
library(RColorBrewer)

####Need to have column names "lat" and "long" in shapefile
April11pt <- readOGR(dsn = "data/Apr11tornPT.shp", layer = "Apr11tornPT")
#Create a new variable and get only magnitude information using the April11
#variable...column name of magnitude is "Name."
Torn11pt <- April11pt@data$MAG


leaflet(data = April11pt) %>% addTiles() %>%
  addMarkers(~long, ~lat, popup = ~paste("Magnitude: ", MAG))
  
#can also do just static text for popup or one field using as.character()
#instead of paste()
############################################################################
################################Points#####################################



############################################################################
#######################Leaflet with calculation#############################
Triangle <- readLines("data\\Triangle.geojson", warn = FALSE) %>%
  paste(collapse = "\n") %>%
  fromJSON(simplifyVector = FALSE)

#Set the style for the Triangle geojson file.
Triangle$style = list(
  weight = 1,
  color = "#555555",     #Green
  opacity = 1,
  fillOpacity = 0.8
)

#sapply and lapply traverse over a set of data (ie list or vector) and 
#calling the specificed function for each item.
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
################################RASTER LEAFLET###########################
#import raster library
library(raster)

#Name variable climate and specify the location of the raster using raster
#expression
climate <- raster("data/precipann_r_nc1.tif")

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
  addLegend(pal = pal, values = values(climate), title = "Annual Rain")
#################################RASTER LEAFLET###########################
############################################################################
