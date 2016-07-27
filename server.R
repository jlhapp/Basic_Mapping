
###########################April 2011 Tornado Outbreak#######################


###########CONVERT TORNADOES SHAPEFILE TO GEOJSON FILE##################
library(tmap) # to read shapefile
library(geojsonio) # to write geojson

#Name variable shp and use read_shape 
shp = read_shape("D:/LearnR/BasicMapping/April2011.shp")
#plot the shp data
qtm(shp)
#use the geojson_write expression followed by ([current file extension],
#file = "[file path] with the name of the geojson you want")
geojson_write(shp, file = "D:/LearnR/BasicMapping/AprilTornado.geojson")
###########CONVERT TORNADOES SHAPEFILE TO GEOJSON FILE##################

##############################LEAFLET###################################
#Set the name "geojson" to the Tornadoes geojson
AprilTorn <- readLines("D:\\LearnR\\BasicMapping\\AprilTornado.geojson", warn = FALSE) %>%
  paste(collapse = "\n") %>%
  fromJSON(simplifyVector = FALSE)

#To map the GeoJSON file to a specific extent, you'll first need to name a
#variable.  Add leaft() %>% and then setView and specify the lat/long. Set 
#the zoom level on a 1-17 scale. 1 = full zoom out, 17 = full zoom in
viewmap <- leaflet() %>% setView(lng = -89.0589, lat = 35.9601, zoom = 5) 
viewmap %>% addGeoJSON(AprilTorn) %>% addTiles()
##############################LEAFLET###################################


#strength is under the column name "Name"