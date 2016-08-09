# Basic Mapping
IMPORT SHAPEFILE

Use rgdal package and the readOGR function.  This will read the projection file.
[variable name]<- readOGR(dsn = "folder location with .shp extension", layer ="name only")


Use maptools package and readShapePoly function.  This will NOT read the projection 
file and you will need to set the projection.
[variable name]<- readShapePoly("folder location with .shp extension")

VIEW MAP

Use plot() function
plot() will display shapefile with no background

If a background map is needed, use ggmap or leaflet

Use ggmap and RgoogleMaps packages to put shapefiles over imagery quickly.
First geocode the center of the map using geocode() command
Then use get_map() command 

#CSV Files
ADD XY INFORMATION FROM CSV FILE
You need to have x,y coordinates in the csv file, each as separate columns.
Import csv into R using read.csv("file location and extension")
To view all of the data and column heading use print([name of variable])
To view the first three rows of data use head([name of variable], 3)


There are two ways to map csv files into points on a map: Using ggmap or using leaflet
Use leaflet:

1. Read the csv file

2. Use cbind function to combine lat/long column.  A new data table will be created

3. Create a Spatial Points Data Frame and define the projection.  Use SPDF function
   set the coordinates to the variable name created in step 2, set the data to the csv
   file and proj4string to WGS84.

4. Use the spTransform function to project to NAD83 UTM17.

5. Add leaflet and markers.

**Code is available in "csv2leaflet" script and you will get a result like this:

![csv](https://cloud.githubusercontent.com/assets/20543318/17519129/9ac0e95c-5e18-11e6-9cc6-daf8cc0d138a.JPG)

Use ggmap to display x,y coordinates on top of map
1. Geocode the center of a map.  variable <- geocode("North Carolina")
2. Map the geocoded point and set zoom level.  variable2 <- get_map((variable), zoom = 7)
3. Set bounding box using goeocded map
4. Get the Stamenmap using the bounding box
5. #use the created map in ggmap and add the UNC table using the "geo_point"
expression.  You must have (data = [your table], aes(x=[the x column name],
y=[the y column name in your table]), color="[color]")

*Code on "csv.R" script and you will get a result like this:
![csv2](https://cloud.githubusercontent.com/assets/20543318/17521919/239a0ccc-5e23-11e6-8ae2-2b9e2a657216.jpeg)


#Rasters

![raster_leaflet](https://cloud.githubusercontent.com/assets/20543318/17521927/2b5cd548-5e23-11e6-9561-62258babb455.jpeg)

#Mapping in Leaflet
This section covers shapefiles; for rasters, see RASTER DATA.  There are many ways to display leaflet map.  If you want a simple map:
leaflet() %>% addPolylines(data = [variable])

This will have no tiles, view set, but a leaflet map will appear

If you want a customized map, create a new variable and set leaflet(), setView(),
and tiles.  You'll want the basics for this portion.  For example:
MyMap <- leaflet() %>% setView(lng = -78.2589, lat = 35.9601, zoom = 8)  %>% addTiles()

Now all you need to do is write MyMap follow by the maggitr operator and add
data (polygons, lines) that you need.  For example:
MyMap %>% addPolylines(data = April11_1) 

Instead of using addPolylines, you can use the following to add various types of data:
-Add lines by using addPolylines()
-Add polygons by using addPolygons()
-Add geojson by using addGeoJSON()
-Add raster by using addRasterImage()
-Add points by using addMarker()

To save online, click Export, and Save as Webpage...it'll install some packages and save html file to your project directory.  **Code for this leaflet map is on the "Leaflet.R" script under the heading "Categorized Tornado Line Leaflet" but there are many other leaflet examples in the same script.

![hurricane_line_leaflet](https://cloud.githubusercontent.com/assets/20543318/17521924/26f27508-5e23-11e6-84d5-3489898f677b.jpeg)


#Shiny

![shiny_points](https://cloud.githubusercontent.com/assets/20543318/17521928/2d4a8404-5e23-11e6-9b13-aeb6651ff7eb.JPG)

#Data Sources used
I dowloaded tornado tracks (lines) from NOAA Southern Region Headquarters: http://www.srh.noaa.gov/srh/ssd/mapping/
I then converted the kml file to a shapefile using the "KML to Layer" tool in ArcGIS for Desktop.

I downloaded the tornado storm reports from NOAA Souther Region Headquarters: http://www.srh.noaa.gov/srh/ssd/mapping/

CSV file of UNC schools were created by looking up individual schools and obtaining xy coordinates using ArcGIS for Desktop's "Add XY Coordinates" tool.

The raster file used in all the raster examples were obtained from the PRISM dataset.
