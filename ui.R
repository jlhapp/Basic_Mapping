
###########################April 2011 Tornado Outbreak#######################

library(leaflet)
library(ggmap)
library(ggplot2)
library(jsonlite)
library(shiny)


shinyUI(fluidPage(
  titlePanel("Tornadoes Map"),
  sidebarLayout(
    sidebarPanel(
      selectInput("Magnitude",
                  label = "Choose Magnitude:",
                  choices = c(EF0,EF1,EF2,EF3,EF4,EF5),
                  selected = 0
      )),
    
    mainPanel (leafletOutput("map","100%",300))
    
  )
))