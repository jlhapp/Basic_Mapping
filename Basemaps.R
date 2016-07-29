#Different types of basemaps available for leaflet
#http://leaflet-extras.github.io/leaflet-providers/preview/index.html

library(leaflet)
library(magrittr)

m <- leaflet() %>% 
  setView(lng = -71.0589, lat = 42.3601, zoom = 8) %>%
  addTiles() 

m

#Some examples
m %>% addProviderTiles("NASAGIBS.ViirsEarthAtNight2012")
m %>% addProviderTiles("NASAGIBS.ModisTerraLSTDay")
m %>% addProviderTiles("Thunderforest.TransportDark")
m %>% addProviderTiles("HikeBike.HikeBike")


#to set a specific date, addTile and then addProvider tiles.  Set the basemap
#you want followed by a comma, and then options = providerTileOptions(time = )
 m2 <- leaflet() %>% 
  setView(lng = 4.5, lat = 51, zoom = 1) %>%
  addTiles() %>% 
  addProviderTiles("NASAGIBS.ModisTerraTrueColorCR",
                   options = providerTileOptions(time = "2015-07-31", opacity = 0.5))

 m2