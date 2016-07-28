############################################################################
#######################Convert shapefile to GeoJSON############################
#Can convert a shapefile to a GeoJSON file using QGIS.  Right click on layer
#and select Save As.  Change the file type to GeoJSON.

#For R script:
#Use the shapefile of weather stations 
library(tmap) # to read shapefile
library(geojsonio) # to write geojson

#Name variable shp and use read_shape 
shp = read_shape("D:/LearnR/BasicMapping/WeatherStations.shp")
#plot the shp data
qtm(shp)
#use the geojson_write expression followed by ([current file extension],
#file = "[file path]")
geojson_write(shp, file = "D:/tmp/shp.geojson")
#######################Convert shapefile to GeoJSON############################
#############################################################################

