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