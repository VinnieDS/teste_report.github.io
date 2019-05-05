## Source of shape file
# http://thematicmapping.org/downloads/world_borders.php


## Download the shape files to working directory ##
download.file("http://thematicmapping.org/downloads/TM_WORLD_BORDERS_SIMPL-0.3.zip" , destfile="TM_WORLD_BORDERS_SIMPL-0.3.zip")
## Unzip them ##
unzip("TM_WORLD_BORDERS_SIMPL-0.3.zip")

## Load Required Packages## 
library(tidyverse)
library(leaflet)
library(rgdal) # R 'Geospatial' Data Abstraction Library. Install package if not already installed.

## Load the shape file to a Spatial Polygon Data Frame (SPDF) using the readOGR() function
myspdf = readOGR(dsn=getwd(), layer="TM_WORLD_BORDERS_SIMPL-0.3")
head(myspdf)
summary(myspdf)

# using the slot data
head(myspdf@data)

## Create map object and add tiles and polygon layers to it
leaflet(data=myspdf) %>% 
  addTiles() %>% 
  setView(lat=10, lng=0 , zoom=2) %>% 
  addPolygons(fillColor = "green",
              highlight = highlightOptions(weight = 5,
                                           color = "yellow",
                                           fillOpacity = 0.7,
                                           bringToFront = TRUE),
              label=~NAME)


#############################################

world <- map("world", fill=TRUE, plot=FALSE)
world_map <- map2SpatialPolygons(world, sub(":.*$", "", world$names))
world_map <- SpatialPolygonsDataFrame(world_map,
                                      data.frame(country=names(world_map), 
                                                 stringsAsFactors=FALSE), 
                                      FALSE)

cnt <- c("Russia", "Afghanistan", "Albania", "Algeria", "Argentina", "Armenia",
         "Azerbaijan", "Bangladesh", "Belarus")

target <- subset(world_map, country %in% cnt)

leaflet(target) %>% 
  addTiles() %>% 
  addPolygons(weight=1)