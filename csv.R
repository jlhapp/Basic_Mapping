###Basics of mapping using shapefiles, csv files with address information, 
###and geojson file.

library(rgdal)
library(sp)
library(ggmap)


############################################################################
###########################csv files#########################################

#Open a csv file named UNC
UNC <- read.csv("D:/LearnR/BasicMapping/UNC.csv")

#View UNC columns and data
print(UNC)

#To find out the x,y min/max of your data use the str expression
str(UNC)

#Display the first three rows of the table
head(UNC, 3)

Tracts <- readOGR(dsn = "D:/LearnR/BasicMapping/NC_Tracts.shp", layer = "NC_Tracts")
plot(Tracts)
gg



#######Create a simple map
points(UNC$X, UNC$Y)

install.packages("ggplot")
library(ggplot2)
ggplot() + geom_point(data = UNC, aes(x=X, y=Y), color="red")



###########################csv files#########################################
############################################################################



