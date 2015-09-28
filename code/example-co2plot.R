# ---------- Using our first R package to display a shapefile! ---------- #
# install the maptools library
install.packages("GISTools")
install.packages('scales')

# import the gistools functions by calling the library() function
library(GISTools)
library(scales)

# --- read in shps --- #
# Building shp
fname_buildings ="https://raw.githubusercontent.com/joeyklee/aloha-r/master/data/example/buildings.geojson"
buildings = readOGR(fname_buildings, 'OGRGeoJSON')
plot(buildings) # plot to inspect

# Roads shp
fname_roads = "https://raw.githubusercontent.com/joeyklee/aloha-r/master/data/example/roads.geojson"
roads = readOGR(fname_roads, 'OGRGeoJSON')
plot(roads) # plot to inspect

# Co2 points
fname_co2 = "https://raw.githubusercontent.com/joeyklee/aloha-r/master/data/example/co2.geojson"
co2 = readOGR(fname_co2, 'OGRGeoJSON')
plot(co2)

# Plot the buildings
plot(buildings, 
     col = "#808080", 
     border=F,
     bg ="#FFFFFF",
     main ="CO2 Mixing Ratios Downtown Vancouver")

# Add the roads to the plot with "add = TRUE"
plot(roads,
     col="#000000",
     lwd=1,
     add=TRUE)

# Add the Paths to the plot with "add = TRUE"
vals = rescale(co2@data$co2, c(0.5, 5))
plot(co2,
     col="#FF6600",
     pch= 20,
     alpha=0.5,
     cex=vals,
     add=TRUE)

# We can even add a north arrow:
north.arrow(xb= -123.144035, yb=49.273001, len=0.0005)
map.scale(xc= -123.151295, 49.271729, len=0.01, ndivs= 2,subdiv=3, units="test")
