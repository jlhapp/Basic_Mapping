
library(leaflet)
library(jsonlite)


v
library(leaflet)
library(jsonlite)
library(shiny)
library(rgdal)

#Set the name "geojson" to a geojson file located on my D drive.
Cat1 <- readLines("D:\\LearnR\\TryGEojson\\Cat1.geojson", warn = FALSE) %>%
  paste(collapse = "\n") %>%
  fromJSON(simplifyVector = FALSE)

Cat2 <- readLines("D:\\LearnR\\TryGEojson\\Cat2.geojson", warn = FALSE) %>%
  paste(collapse = "\n") %>%
  fromJSON(simplifyVector = FALSE)

#readOGR won't work
##Category1 <- readOGR("D:\\LearnR\\TryGEojson\\Cat1.geojson",
##layer = "Cat1.geojson", verbose = FALSE)


viewmap <- leaflet() %>% setView(lng = -76.0589, lat = 34.9601, zoom = 7) 
viewmap %>% addGeoJSON(Cat1) %>% addTiles()


#############################Hurricane Leaflet##############################
############################################################################






############################################################################
#######################Leaflet with calculation#############################
geojson <- readLines("D:\\LearnR\\TryGEojson\\Triangle.geojson", warn = FALSE) %>%
  paste(collapse = "\n") %>%
  fromJSON(simplifyVector = FALSE)

geojson$style = list(
  weight = 1,
  color = "#555555",
  opacity = 1,
  fillOpacity = 0.8
)

tot_population <- sapply(geojson$features, function(feat){
  feat$properties$DP0010001
})

whi_population <- sapply(geojson$features, function(feat){
  feat$properties$DP0010002
})

perc <- colorQuantile("Greens", whi_population/tot_population)

#######
geojson$features <- lapply(geojson$features, function(feat) {
  feat$properties$style <- list(
    fillColor = perc(
      feat$properties$DP0010002 / max(1, feat$properties$DP0010001)
    )
  )
  feat
})

leaflet() %>% addGeoJSON(geojson) %>% addTiles()

#######################Leaflet with calculation#############################
############################################################################




###To save online, click Export, and Save as Webpage...it'll install some packages and save html
###file to your project directory.