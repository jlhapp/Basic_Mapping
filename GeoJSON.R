###Basics of mapping using shapefiles, csv files with address information, 
###and geojson file.

#GeoJSON is a JavaScript object with geographic data.  Also, leaflet is
#designed to work natively with GeoJSON.

library(shiny)
library(rgdal)
library(sp)
library(ggmap)
library(leaflet)
library(jsonlite)

############################################################################
###########################GeoJSON files#####################################
#Set the name "geojson" to a geojson file located on my D drive.
Cat1 <- readLines("data\\Cat1.geojson", warn = FALSE) %>%
  paste(collapse = "\n") %>%
  fromJSON(simplifyVector = FALSE)

#Read GeoJSON file using readOGR
Cateogry_1 <- readOGR(dsn = "data\\Cat1.geojson", layer = "OGRGeoJSON",
                      stringsAsFactors = FALSE, verbose = FALSE)


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

#possibly feature.properties
data <- getcom

Cateogry_1$Season
###########################GeoJSON files#####################################
############################################################################
