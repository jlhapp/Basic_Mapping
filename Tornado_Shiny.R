library(shiny)
library(leaflet)
library(RColorBrewer)

#This will create a leaflet map with a slider for magnitude of tornado (1-5 scale)
#leaflet will create a static map and leafletProxy will mangage the dynamic
#elements.  You need leafletProxy() function to modify a map that's already
#running in a page.


#Import April 2011 tornado outbreak point shapefile using readOGR
April11pt <- readOGR(dsn = "D:/LearnR/BasicMapping/Apr11tornPT.shp", layer = "Apr11tornPT")


#############################UI##########################################
ui <- bootstrapPage(
  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
  #call the leaflet map and specify width and height
  leafletOutput("map", width = "100%", height = "100%"),
  #have a panel on top of the map and specify the width and height
  absolutePanel(top = 10, right = 10,
                
                #create a slider input bar. first add the type of slider, followed
                #by the title of the slider input.  set the minimumn and maximumn number
                #by using min and max followed by the shapefile variable, $, and the 
                #column name.  Set the value to range and reference the shapefile and 
                #column. Finally set the number to step.
                sliderInput("range", "Magnitudes", min(April11pt$MAG), max(April11pt$MAG),
                            value = range(April11pt$MAG), step = 1
                ),
                selectInput("colors", "Color Scheme",
                            rownames(subset(brewer.pal.info, category %in% c("seq", "div")))
                ),
                #create a checkbox to allow the user to turn on/off the legend
                #First, reference the "legend" variable used in the server file
                #(if input$legend), then name the checkbox, and write TRUE.
                checkboxInput("legend", "Show legend", TRUE)
  )
)
#############################UI##########################################

#################################SERVER######################################
server <- function(input, output, session) {
  #To use the slide, you need a "reactive" function.  Here I'm naming a variable
  #filteredData and using the reactive function
  filteredData <- reactive({
    #here I'm referencing the shapefile, followed by the shapefile and the column
    #you want and then "input$range" expression that is used in the sliderInput
    #in the UI.
    April11pt[April11pt$MAG >= input$range[1] & April11pt$MAG <= input$range[2],]
  })
  
  
  colorpal <- reactive({
    colorNumeric(input$colors, April11pt$MAG)
  })
  
  #Create and render a leaflet map.  the variable "map" created here will
  #be referenced in the leafletProxy below and in the leafletOutput in the UI.
  output$map <- renderLeaflet({
    #add leaflet here by using your shapefile and add tiles
    leaflet(April11pt) %>% addTiles() %>%
      #"calculate the extent."  Since you are using point data you already 
      #have lat/long in your table...so all you need to do, is write the code
      #below
      fitBounds(~min(long), ~min(lat), ~max(long), ~max(lat))
  })
  
  observe({
    pal <- colorpal()
    
    
    #Since you need leafletProxy() function to modify a map that's already
    #running in a page, you'll want to add the leafletProxy here.  Reference
    #the name of the map (from the Output$map) and use the filtered data for
    #the data.
    leafletProxy("map", data = filteredData()) %>%
      #You'll want to refresh the map by clearing the shapes
      clearShapes() %>%
      #Re-add the the points.  Change size of the points by changing the
      #radius (was ~10^MAG/10)
      addCircles(radius = 7500, weight = 1, color = "#777777",
                 fillColor = ~pal(MAG), fillOpacity = 1, popup = ~paste(MAG)
      )
  })
  
  observe({
    proxy <- leafletProxy("map", data = April11pt)
    
    # Remove any existing legend, and only if the legend is
    # enabled, create a new one.
    proxy %>% clearControls()
    #This states if the legend checkbox is turned on...
    if (input$legend) {
      pal <- colorpal()
      proxy %>% addLegend(position = "bottomright",
                          pal = pal, values = ~MAG
      )
    }
  })
}

#################################SERVER######################################

#run the shiny app
shinyApp(ui, server)

