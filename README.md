# Basic_Mapping
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
**Code is available in "csv2leaflet" script.



Use ggmap to display x,y coordinates on top of map
1. Geocode the center of a map.  variable <- geocode("North Carolina")
2. Map the geocoded point and set zoom level.  variable2 <- get_map((variable), zoom = 7)
3. Set bounding box using goeocded map
4. Get the Stamenmap using the bounding box
5. #use the created map in ggmap and add the UNC table using the "geo_point"
expression.  You must have (data = [your table], aes(x=[the x column name],
y=[the y column name in your table]), color="[color]")

*Code on "csv.R" script


![csv](https://cloud.githubusercontent.com/assets/20543318/17519129/9ac0e95c-5e18-11e6-9cc6-daf8cc0d138a.JPG)

![csv2](https://cloud.githubusercontent.com/assets/20543318/17521919/239a0ccc-5e23-11e6-8ae2-2b9e2a657216.jpeg)

#Rasters

![raster_leaflet](https://cloud.githubusercontent.com/assets/20543318/17521927/2b5cd548-5e23-11e6-9561-62258babb455.jpeg)

#Leaflet

![hurricane_line_leaflet](https://cloud.githubusercontent.com/assets/20543318/17521924/26f27508-5e23-11e6-84d5-3489898f677b.jpeg)


#Shiny

![shiny_points](https://cloud.githubusercontent.com/assets/20543318/17521928/2d4a8404-5e23-11e6-9b13-aeb6651ff7eb.JPG)
