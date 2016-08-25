############################################################################
#######################Convert shapefile to GeoJSON############################
#Can convert a shapefile to a GeoJSON file using QGIS.  Right click on layer
#and select Save As.  Change the file type to GeoJSON.

#For R script:
#Use the shapefile of weather stations 
library(geojsonio) # to write geojson

#Name variable shp and use read_shape 
shp = readOGR("data/WeatherStations.shp", "WeatherStations")

#use the geojson_write expression followed by ([current file extension],
#file = "[file path]")
geojson_write(shp, file = "D:/tmp/shp.geojson")
#######################Convert shapefile to GeoJSON############################
#############################################################################
