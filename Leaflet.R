
library(leaflet)
library(jsonlite)


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