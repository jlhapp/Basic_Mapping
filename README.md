#How to use this repository
  1.  This repostiory is intended for new R and GIS users.
  2.  Scroll through the readme file or click on a section you are interested in within the Table of Contents to read a description of the scripts.
  3.  If you are a Duke University user, [click here and follow the instructions in the pdf file] [22].  You will be able to copy and paste these scipts into your R project and view the results.  All other users can view/copy the scripts and replicate with your data.
  4.  **First copy and paste the ["Install_Packages"][50] script into your project to install all of the necessary packages.**

#Table of Contents:
  1.  [Basic Mapping][42] - learn how what a shapefile is, how to import a shapefile, view a map, clip a shapefile, merge two shapefiles together, and perform joins(both spatial and attribute).
  2.  [CSV Files][40] - import a csv with xy coordinates and view in leaflet or in a plot.
  3.  [Rasters][43] - learn what a raster is, import a raster, define a color palette for the raster, and view in leaflet.
  4.  [Mapping in Leaflet][44] - add various mapping file types to a leaflet.
  5.  [GeoJSON files][46] - learn the benefits of using GeoJSON files and how to add them to leaflet.
  6.  [Basemaps][47] - add basemaps from Leaflet's github webpage.
  7.  [Projections in R][48] - learn the terminology of projections in R and set the projections.
  8.  [Shiny][41] - brief introduction to a Shiny application with a Leaflet map.
  9.  [Data sources used][45] - links to the raw data sources that are used in this repository.

[40]: https://github.com/jlhapp/Basic_Mapping#csv-files
[41]: https://github.com/jlhapp/Basic_Mapping#shiny
[42]: https://github.com/jlhapp/Basic_Mapping#basic-mapping
[43]: https://github.com/jlhapp/Basic_Mapping#rasters
[44]: https://github.com/jlhapp/Basic_Mapping#mapping-in-leaflet
[45]: https://github.com/jlhapp/Basic_Mapping#data-sources-used
[46]: https://github.com/jlhapp/Basic_Mapping#geojson-files
[47]: https://github.com/jlhapp/Basic_Mapping#basemaps
[48]: https://github.com/jlhapp/Basic_Mapping#projections-in-r
[49]: https://github.com/jlhapp/Basic_Mapping#table-of-contents
[50]: https://github.com/jlhapp/Basic_Mapping/blob/master/Install_Packages


# Basic Mapping
*WHAT ARE SHAPEFILES?*

In short, shapefiles are spatial files with attribute information and they can be points, lines, or polygons.  For instance, if you have a United States polygon shapefile, each state will have information (i.e. name, abbreviation, FIPS code, etc.) within the attribute table.

![shapefile types](https://cloud.githubusercontent.com/assets/20543318/18320380/90b35f9e-74f7-11e6-9a41-774b483c555f.jpg)

*IMPORT SHAPEFILE*

Use rgdal package and the readOGR function to import a shapefile into R.  The readOGR function will read the projection file.
*new object name*<- readOGR(dsn = "folder location with .shp extension", layer ="name only")

Users can also utilize the maptools package and the readShapePoly function.  The readShapePoly function will NOT read the projection file and you will need to set the projection.
*new object name* <- readShapePoly("folder location with .shp extension")

*VIEW MAP*

Use plot() function to view the map.  The plot() function will display the shapefile with no background.  If a background map is needed, use ggmap or leaflet.  **Code for readOGR and plot are found in the ["Shapefiles.R"][18] script.

If you want to put shapefiles over imagery quickly, use ggmap and RgoogleMaps packages.  First geocode the center of the map using geocode() function.  Then use get_map() function.  **Code is found in the ["csv.R"][20] script.

*CLIP TWO SHAPEFILE LAYERS*

First import both shapefile layers and view the extents of both layers using bbox() function.  If needed, use the spTransform() function to project one layer to the other layer.  Create a new object and set the newly projected layer to the polygon.  In order to export the new spatial data frame to a shapefile, use the writeOGR() function.  **Code is in the ["Clip.R"][13] script and you will get a result like this:

![clip](https://cloud.githubusercontent.com/assets/20543318/17530536/f3403420-5e45-11e6-8718-1ff37892d617.jpg)

*MERGE TWO SHAPEFILE LAYERS TOGETHER*

You will need the rgdal, raster, rgeos libraries.  First import both shapefiles using the readOGR() function.  Finally, use the union function (for example: union(*shp1*, *shp2*)) and plot the result.  **Code is available in the ["Merge.R"][15] script.

*JOIN SHAPEFILE AND CSV ATTRIBUTES*

You will need the sp library.  First import the shapefile and csv files using readOGR() function and read.csv() function respectively.  Note the names of the fields/columns that you will need to merge the two datasets together.  Name a new object and use the merge() function.  The csv fields will essentially be appended to the end of the shapefile fields/columns.  **Code is available in the ["AttributeJoin.R"][11] script.   

*SPATIAL JOIN ON POINT AND POLYGON LAYERS*

Import the rgdal library and both shapefiles.  Use the over() function to return the rows for the column you specify.  Then join back the new data created from the over() function by creating a new variable with a new column that you create.  **See ["Spatial_Join.R"][19] script to view an example.

[Back to top][49]

#CSV Files
In order to add xy information from a csv file, you need to have x, y coordinates in the csv file, separating the x and y coordinates into two columns.  Import the csv file into R using read.csv("file location and extension").  To view all of the data and column headings, use the print() function.  To view the first three rows of data use the head function.  For example: head(*object name*, 3)

There are two ways to map csv files into points on a map: using ggmap or using leaflet.

*Using leaflet:*

  1. Read the csv file and load the leaflet library.
  2. Use cbind function to combine lat/long column.  A new data table will be created.
  3. Create a Spatial Points Data Frame and define the projection.  Use SPDF function set the coordinates to the object name created in step 2, set the data to the csv file and proj4string to WGS84.
  4. Use the spTransform function to project to NAD83 UTM17.
  5. Add leaflet and markers.

**Code is available in ["csv2leaflet.R"][21] script and you will get a result like this:

![csv](https://cloud.githubusercontent.com/assets/20543318/17519129/9ac0e95c-5e18-11e6-9cc6-daf8cc0d138a.JPG)

*Using ggmap to display x,y coordinates on top of a Google map:*
  1. Geocode the center of a map.  *object1* <- geocode("North Carolina")
  2. Map the geocoded point and set zoom level.  *object2* <- get_map((*object1*), zoom = 7)
  3. Set bounding box using goeocded map.
  4. Get the Stamenmap using the bounding box.
  5. Use the created map in ggmap and add the UNC table using the "geo_point" expression.  You must have (data = *your table*, aes(x=*x column name*, y=*y column name*), color="*color*")

**Code is on ["csv.R"][20] script and you will get a result like this:
![csv2](https://cloud.githubusercontent.com/assets/20543318/17521919/239a0ccc-5e23-11e6-8ae2-2b9e2a657216.jpeg)

[Back to top][49]

#Rasters
*WHAT ARE RASTERS?*

In short, rasters are cells that have values and are arranged into rows and columns.  Examples of rasters include scanned maps, imagery data, and surface maps (the example that is used in this repository).

![intro to rasters](https://cloud.githubusercontent.com/assets/20543318/18321112/a852883e-74fa-11e6-9177-358f5e1ec00d.jpg)

*IMPORT A RASTER*

Use either the raster library or the sp package to import raster data.

1. RASTER LIBRARY

 - Using the raster package will return a RasterLayout object and you will need to visualize using the plot() function.
 - To import name a object and use raster() function.  For example:   *object* <- raster("folder location.tif")
 - To view the map with a legend, use plot().  For example:  plot(*object name*)

2. SP PACKAGE
   
 - Using the SP package will return a SpatialGridDataFrame and you will need to visualize using the spplot() function.
 - To import name a object and use readGDAL() function.   For example:   *object* <- readGDAL("folder location.tif")
 - To view the map with a legend, use spplot().  For example:  spplot(*object*)

Code is on ["Rasters.R"][16] script.

*RASTERS IN LEAFLET*

Use the raster() function to import the raster layer.  You will need to specify color scheme using the colorNumeric() function.  Name an object 'pal', and call the colorNumeric() funtion.  Then specify color scheme choices using "c()", set the color values to the raster object and write code that specifies any part of the raster that has no value to transparent.  For example:

pal <- colorNumeric(c("#0C2C84", "#41B6C4", "#FFFFCC"), values(*object*), na.color = "transparent")

Now that there's a object named 'pal' for the color scheme we can add this to leaflet.  First add leaflet() and tiles() separated by the maggrittr (%>%) operator.  Then add the raster using the addRasterImage() fucntion.  Within the addRasterImage() function, you'll need to specify the data, colors, and opacity.  Then you can add legend if you'd like using the addLegend() function.  For example:

leaflet() %>% addTiles() %>%  addRasterImage(climate, colors = pal, opacity = 0.8) %>%  
    addLegend(pal = pal, values = values(climate), title = "Annual Rain")

*You will get a result that looks like this.  Code is available in the ["Leaflet.R"][14] script under "RASTER LEAFLET" section. 
![raster_leaflet](https://cloud.githubusercontent.com/assets/20543318/17521927/2b5cd548-5e23-11e6-9561-62258babb455.jpeg)

[Back to top][49]

#Mapping in Leaflet
This section covers shapefiles; for rasters in leaflet, see RASTER.  There are many ways to display a leaflet map.  If you want a simple map write this: leaflet() %>% addPolylines(data = *object*)

This leaflet map will have no tiles or view set, but a leaflet map will appear.

If you want a customized map, create a new object and set leaflet(), setView(), and tiles.  This will make it easier to add objects one at a time.  For example: MyMap <- leaflet() %>% setView(lng = -78.2589, lat = 35.9601, zoom = 8)  %>% addTiles()

Now all you need to do is write the "MyMap" object follow by the maggitr operator (%>%) and add data (polygons, lines, etc.) that you need.  For example: MyMap %>% addPolylines(data = April11) 

Instead of using addPolylines, you can use the following to add various types of data:
  - Add polygons by using addPolygons()
  - Add geojson by using addGeoJSON()
  - Add raster by using addRasterImage()
  - Add points by using addMarker()

To save the leaflet to an html file, click Export in the Viewer window within R, and Save as Webpage...R will install some packages and save the html file to your project directory.  **Code for this leaflet map is in the ["Leaflet.R"][14] script under the heading "Categorized Tornado Line Leaflet" but there are many other leaflet examples in the same script.

![hurricane_line_leaflet](https://cloud.githubusercontent.com/assets/20543318/17524043/d9eb5a6a-5e2a-11e6-949b-a2e544777bce.jpeg)

[Back to top][49]

#GeoJSON Files

The primary benefits of using GeoJSON is that it is a JavaScript object with geographic data.  Also, leaflet is designed to work natively with GeoJSON.  Users can convert a shapefile to a GeoJSON file using QGIS or in R.  To convert in QGIS, right click on layer and select Save As.  Change the file type to GeoJSON and save the new layer.

To convert a shapefile to a GeoJSON file in R, first load tmap and geojsonio libraries.  Then write the following steps:

   1. Name object and use read_shape() function.  For example:   shp = read_shape("file location.shp") 
   2. Plot "shp" object using qtm expression.  qtm is the tmap's version of plotting a map. For example:   qtm(shp)
   3. Use the geojson_write() function with the following code in the function (*current file extension*,  file = "*file path*").  For example geojson_write(shp, file = "D:/tmp/shp.geojson")

To import GeoJSON files in leaflet use the readLines() function.  **Code for GeoJSON conversion is available in ["Shapefile2GeoJSON.R"][17] script and the GeoJSON example in leaflet is available in the "GeoJSON.R" script.

[Back to top][49]

#Basemaps
Users can use many different types of basemaps in R.  For a full list of available basemaps, go to the [Leaflet extras github][5] webpage.  **For examples of using different basemaps, see the ["Basemaps.R"][12] code.

[Back to top][49]

#Projections in R
To view detailed Datum information type the following command in R.  This will show you what the abbreviations mean: projInfo(type = "datum")

To view detailed Projection information type the following command in R: projInfo(type = "proj")

To view detailed Ellipsoid information type the following command in R: projInfo(type = "ellps")

Obtain EPSG codes from the [EPSG Geodetic Parameter Registry][6] website.

You will need sp and rgdal libraries to transform coordinate systems.  Here are common codes used in the United States and North Carolina.
 - WGS84 = EPSG: 4326
 - NAD83 = EPSG: 4269
 - NAD83 Zone 17 = EPSG: 26917

When you view the projection information, you will see (if necessary) information including:
  1. Projection (Latitude/Longitude, UTM/Zone, etc.)
  2. Datum
  3. Units
  4. Ellipsoid
 
Once the shapefile is imported use the proj4string(*object*) fucntion or print(proj4string(*object*)) function to read the projection.  If there is no projection or if you use readShapePoly() fucntion, you will get a result of "[[1]] NA."

*THREE WAYS TO SET PROJECTION*
  1. Use proj4string(*object*) <- "+proj=utm +zone=14 +datum=WGS84 +units=m" function
  2. Use proj4string(*object*) <- CRS(+init=epsg:32119") function
  3. To convert between different mapping projections and datums use the spTransform() function.  For example: shpData <- spTransform(states, CRS("+proj=longlat +datum=WGS84")) 

**You can't use the third way if no projection is set...you'd need to use the first or second method.**  **Example code is available in the ["Shapefiles.R"][18] and "Clip.R" scripts.

You can also remove a projection using    proj4string(*object*) <- NA_character_   function.

*RASTER PROJECTION INFORMATION*

Use the projection(*object*) function to view a raster's projection.

To set a new projection for rasters:

  1. Create a new object and set it to the raster
  2. Use the projectRaster() function.

**Code is in the ["Rasters.R"][16] script

[Back to top][49]

#Shiny

Shiny allows the user to interact with the leaflet.  To view detailed code, see the "Tornado_Shiny.R" (for points) and "Tornado_Shiny_Lines.R" (for polylines).  Both examples use the bootstrapPage() but another common type of page is the fluidPage().  You can write a Shiny app either in two R scripts (named: ui.R and server.R) or in one app with the ui and server written in the script.  Both examples use one script.

When using leaflet with shiny app, you need "leafletOutput" in the ui.R file and renderLeaflet() in the server.R file.  Users will also need the leafletProxy() function to modify a map that's already running in a page.  Another function you must have in Shiny is the reactive() function.  This will update when the user changes the user interface.  The "Tornado_Shiny.R" script will give you a user interface like this:

![shiny_points](https://cloud.githubusercontent.com/assets/20543318/17521928/2d4a8404-5e23-11e6-9b13-aeb6651ff7eb.JPG)

[Back to top][49]

#Data Sources used
The tornado tracks (lines) were downloaded from [NOAA Southern Region Headquarters][1].   The files were then converted from kml to a shapefile using the "KML to Layer" tool in ArcGIS for Desktop.  The tornado storm reports (points) were downloaded from [NOAA Southern Region Headquarters][2].

The csv file of UNC schools were created by looking up individual schools and geocoding the addresses in ArcGIS for Desktop.  Once a shapefile was created, the xy coordinates were created using the "Add XY Coordinates" tool in ArcGIS for Desktop.

The raster file used in all the raster examples were obtained from the [Natural Resources Conservation Service GeoSpatial Gateway][3].  It was obtained at the state level, 1981-2010 Annual Average Raster Precip and Temp (Climate PrismRaster dataset).

Hurricane data was obtained from the [NOAA National Centers for Environmental Information][4].

State polygon shapefiles were obtained from the [United States Census Bureau Tiger/Line Shapefiles.][7]  The American Community Survey data was downloaded from the United States Census Bureau using the [American Community Survey 5-Year Estimates - Geodatabase Format][9].  Once the geodatabase was imported into ArcGIS for Desktop, the shapefile and table was exported to a shapefile and a csv file.   

[Back to top][49]

By: Jena

[1]: http://www.srh.noaa.gov/srh/ssd/mapping/
[2]: http://www.srh.noaa.gov/srh/ssd/mapping/
[3]: https://gdg.sc.egov.usda.gov/GDGHome.aspx
[4]: http://www.ncdc.noaa.gov/ibtracs/index.php?name=ibtracs-data
[5]: http://leaflet-extras.github.io/leaflet-providers/preview/index.html
[6]: http://www.epsg-registry.org
[7]: https://www.census.gov/geo/maps-data/data/tiger-line.html
[9]: https://www.census.gov/geo/maps-data/data/tiger-data.html
[11]: https://github.com/jlhapp/Basic_Mapping/blob/master/AttributeJoin
[12]: https://github.com/jlhapp/Basic_Mapping/blob/master/Basemaps.R
[13]: https://github.com/jlhapp/Basic_Mapping/blob/master/Clip
[14]: https://github.com/jlhapp/Basic_Mapping/blob/master/Leaflet.R
[15]: https://github.com/jlhapp/Basic_Mapping/blob/master/Merge
[16]: https://github.com/jlhapp/Basic_Mapping/blob/master/Rasters.R
[17]: https://github.com/jlhapp/Basic_Mapping/blob/master/Shapefile2GeoJSON.R
[18]: https://github.com/jlhapp/Basic_Mapping/blob/master/Shapefiles.R
[19]: https://github.com/jlhapp/Basic_Mapping/blob/master/Spatial_Join
[20]: https://github.com/jlhapp/Basic_Mapping/blob/master/csv.R
[21]: https://github.com/jlhapp/Basic_Mapping/blob/master/csv2leaflet.R
[22]: https://duke.box.com/v/LearnR
