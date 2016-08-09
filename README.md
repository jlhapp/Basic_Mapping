# Basic Mapping
*IMPORT SHAPEFILE*

Use rgdal package and the readOGR function.  This will read the projection file.
[variable name]<- readOGR(dsn = "folder location with .shp extension", layer ="name only")

Use maptools package and readShapePoly function.  This will NOT read the projection 
file and you will need to set the projection.
[variable name]<- readShapePoly("folder location with .shp extension")

*VIEW MAP*

Use plot() function to view the map.  The plot() function will display the shapefile with no background.  If a background map is needed, use ggmap or leaflet.

Use ggmap and RgoogleMaps packages to put shapefiles over imagery quickly.  First geocode the center of the map using geocode() command.  Then use get_map() command 

*CLIP TWO SHAPEFILE LAYERS*

Import both shapefile layers.  View the extents of both layers using bbox() function.  If need be, use the spTransform function to project one layer to the other layer.  Create new object and set the newly projected layer to the polygon.  **Code is in the "Clip.R" script.

#CSV Files
In order to add xy information from a csv file, you need to have x,y coordinates in the csv file, separating x and y into two columns.  Import csv into R using read.csv("file location and extension")
To view all of the data and column heading use print([name of variable])
To view the first three rows of data use head([name of variable], 3)

There are two ways to map csv files into points on a map: Using ggmap or using leaflet

*Using leaflet:*

  1. Read the csv file
  2. Use cbind function to combine lat/long column.  A new data table will be created
  3. Create a Spatial Points Data Frame and define the projection.  Use SPDF function set the coordinates to the variable name created in step 2, set the data to the csv file and proj4string to WGS84.
  4. Use the spTransform function to project to NAD83 UTM17.
  5. Add leaflet and markers.

**Code is available in "csv2leaflet" script and you will get a result like this:

![csv](https://cloud.githubusercontent.com/assets/20543318/17519129/9ac0e95c-5e18-11e6-9cc6-daf8cc0d138a.JPG)

*Using ggmap to display x,y coordinates on top of a Google map:*
  1. Geocode the center of a map.  variable <- geocode("North Carolina")
  2. Map the geocoded point and set zoom level.  variable2 <- get_map((variable), zoom = 7)
  3. Set bounding box using goeocded map
  4. Get the Stamenmap using the bounding box
  5. #use the created map in ggmap and add the UNC table using the "geo_point" expression.  You must have (data = [your table], aes(x=[the x column name], y=[the y column name in your table]), color="[color]")

**Code on "csv.R" script and you will get a result like this:
![csv2](https://cloud.githubusercontent.com/assets/20543318/17521919/239a0ccc-5e23-11e6-8ae2-2b9e2a657216.jpeg)


#Rasters
Use either raster library or sp package to import data.

1. RASTER LIBRARY
   
 - Using the raster package will return a RasterLayout object and you will need to visualize using the plot() function
 - To import name a variable and use raster() function.  For example:   variable <- raster("folder location.tif")
 - To view the map with a legend, use plot().  For example:  plot(variable)

2. SP PACKAGE
   
 - Using the SP package will return a SpatialGridDataFrame and you will need to visualize using the spplot() function.
 - To import name a variable and use readGDAL() function.   For example:   variable <- readGDAL("folder location.tif")
 - To view the map with a legend, use spplot().  For example:  spplot(variable)

Code on "Rasters.R" script



RASTERS IN LEAFLET

Use raster() to import layer.  You need to specify color scheme use <- colorNumeric function.  Name variable 'pal' use <- operator and colorNumeric funtion.  Then specify color scheme choices using "c()", set values to the raster variable and any part of the raster that has no value to transparent.  For example:

pal <- colorNumeric(c("#0C2C84", "#41B6C4", "#FFFFCC"), values([variable]), na.color = "transparent")

Now that there's a variable named pal for the color scheme we can add this to leaflet.  First add leaflet() and  tiles() separated by %>% operator.  Then add the raster using the "addRasterImage()."  Within addRasterImage, you'll need to first specify the data, colors = [variable from color scheme above], and opacity.  Then you can add legend if you'd like.  For example:

leaflet() %>% addTiles() %>%
addRasterImage(climate, colors = pal, opacity = 0.8) %>%
  addLegend(pal = pal, values = values(climate), title = "Annual Rain")

*You will get a result that looks like this.  Code is in "Leaflet.R" script under "RASTER LEAFLET" section. 
![raster_leaflet](https://cloud.githubusercontent.com/assets/20543318/17521927/2b5cd548-5e23-11e6-9561-62258babb455.jpeg)

#Mapping in Leaflet
This section covers shapefiles; for rasters, see RASTER.  There are many ways to display leaflet map.  If you want a simple map:
leaflet() %>% addPolylines(data = [variable])

This will have no tiles, view set, but a leaflet map will appear

If you want a customized map, create a new variable and set leaflet(), setView(), and tiles.  You'll want the basics for this portion.  For example: MyMap <- leaflet() %>% setView(lng = -78.2589, lat = 35.9601, zoom = 8)  %>% addTiles()

Now all you need to do is write MyMap follow by the maggitr operator and add data (polygons, lines) that you need.  For example: MyMap %>% addPolylines(data = April11_1) 

Instead of using addPolylines, you can use the following to add various types of data:
  - Add lines by using addPolylines()
  - Add polygons by using addPolygons()
  - Add geojson by using addGeoJSON()
  - Add raster by using addRasterImage()
  - Add points by using addMarker()

To save online, click Export, and Save as Webpage...it'll install some packages and save html file to your project directory.  **Code for this leaflet map is on the "Leaflet.R" script under the heading "Categorized Tornado Line Leaflet" but there are many other leaflet examples in the same script.

![hurricane_line_leaflet](https://cloud.githubusercontent.com/assets/20543318/17524043/d9eb5a6a-5e2a-11e6-949b-a2e544777bce.jpeg)


#Data Sources used
The tornado tracks (lines) were downloaded from [NOAA Southern Region Headquarters][1].   The files were then converted from kml to a shapefile using the "KML to Layer" tool in ArcGIS for Desktop.  The tornado storm reports (points) were downloaded from [NOAA Southern Region Headquarters][2].

CSV file of UNC schools were created by looking up individual schools and obtaining xy coordinates using ArcGIS for Desktop's "Add XY Coordinates" tool.

The raster file used in all the raster examples were obtained from the [Natural Resources Conservation Service GeoSpatial Gateway][3].  It was obtained at the state level, 1981-2010 Annual Average Raster Precip and Temp (Climate PrismRaster dataset).

Hurricane data was obtained from the [NOAA National Centers for Environmental Information][4].

State polygon files were obtained from the [United States Census Bureau Tiger/Line Shapefiles.][7]

[1]: http://www.srh.noaa.gov/srh/ssd/mapping/
[2]: http://www.srh.noaa.gov/srh/ssd/mapping/
[3]: https://gdg.sc.egov.usda.gov/GDGHome.aspx
[4]: http://www.ncdc.noaa.gov/ibtracs/index.php?name=ibtracs-data
[7]: https://www.census.gov/geo/maps-data/data/tiger-line.html


#GeoJSON Files

The primary benefits of using GeoJSON is that it is a JavaScript object with geographic data.  Also, leaflet is designed to work natively with GeoJSON.

Users can convert a shapefile to a GeoJSON file using QGIS or in R.  To convert in QGIS, right click on layer and select Save As.  Change the file type to GeoJSON.

To convert to a shapefile in R, first load tmap and geojsonio libraries

   1. Name variable and use read_shape.  For example:   shp = read_shape("file location.shp") 
   2. Plot shp data using qtm expression. For example:   qtm(shp)
   3. Use the geojson_write expression followed by ([current file extension],  file = "[file path]").  For example geojson_write(shp, file = "D:/tmp/shp.geojson")

To import GeoJSON files in leaflet use readLines function.  **Code is available in "Shapefile2GeoJSON.R" script.


#Basemaps
Users can use many different types of basemaps in R.  For a full list of available basemaps, go to the ["Leaflet extras github"][5] webpage.

[5]: http://leaflet-extras.github.io/leaflet-providers/preview/index.html

#Projections in R
To view detailed Datum information type the following command in R.  This will show you what the abbreviations mean: projInfo(type = "datum")

To view detailed Projection information type the following command in R: projInfo(type = "proj")

To view detailed Ellipsoid information type the following command in R: projInfo(type = "ellps")

Obtain EPSG codes from the [EPSG Geodetic Parameter Registry][6] website.
[6]: http://www.epsg-registry.org

You will need sp and rgdal libraries to transform coordinate systems.  Here are common codes used in the United States and North Carolina.
 - WGS84 = EPSG: 4326
 - NAD83 = EPSG: 4269
 - NAD83 Zone 17 = EPSG: 26917


When you view the projection information, you will see (if necessary) information including:
  1. Projection (Latitude/Longitude, UTM/Zone, etc.)
  2. Datum
  3. Units
  4. Ellipsoid
 
Once the shapefile is imported use the proj4string([variable]) fucntion or print(proj4string([variable])) to read the projection.  If there is no projection or since readShapePoly will not read the projection file, you will get a result of [1] NA.

*THREE WAYS TO SET PROJECTION*
  1. Use proj4string([variable]) <- "+proj=utm +zone=14 +datum=WGS84 +units=m" function
  2. Use proj4string([variable]) <- CRS(+init=epsg:32119") function
  3. Or create a new variable using spTransform function.  For example: shpData <- spTransform(states, CRS("+proj=longlat +datum=WGS84")) 

**You can't use the third way if no projection is set...you'd need to use the first method.**

You can also remove a projection using proj4string([variable]) <- NA_character_

To convert between different mapping projections and datums use the spTransform() command.


*RASTER PROJECTION INFORMATION*

Use the projection([variable]) function to view projection

To set a new projection:

  1. Create a new variable and set it to information
  2. use the projectRaster() function

**Code is in the "Rasters.R" script

#Shiny

![shiny_points](https://cloud.githubusercontent.com/assets/20543318/17521928/2d4a8404-5e23-11e6-9b13-aeb6651ff7eb.JPG)
