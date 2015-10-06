# Install the leaflet library
devtools::install_github("rstudio/leaflet")
library(leaflet)

# --------------- first leaflet map --------------- #
# initiate the leaflet instance and store it to a variable
m = leaflet()

# we want to add map tiles so we use the addTiles() function - the default is openstreetmap
m = addTiles(m)

# we can add markers by using the addMarkers() function
m = addMarkers(m, lng=-123.256168, lat=49.266063, popup="T")

# we can "run"/compile the map, by running the printing it
print(m)


# --------------- first leaflet map --------------- #
# data_filter = read.csv('', header=T)

# subset out your data:
df_graffiti_noise = subset(data_filter, cid == 1)
df_street_traffic_maint = subset(data_filter, cid == 2)
df_garbage_recycling_organics = subset(data_filter, cid == 3)
df_water = subset(data_filter, cid == 4)
df_animal_vegetation = subset(data_filter, cid == 5)
df_other = subset(data_filter, cid == 0)

m = leaflet()
m = addTiles(m)

colorFactors = colorFactor(c('red', 'orange', 'purple', 'blue', 'pink', 'brown'), domain=data_filter$cid)
m = addCircleMarkers(m, 
                      lng=df_graffiti_noise$lon_offset, lat=df_graffiti_noise$lat_offset, 
                      popup=df_graffiti_noise$Case_Type, 
                      radius=2, 
                      stroke = FALSE, fillOpacity = 0.75,
                      color = colorFactors(df_graffiti_noise$cid),
                      group = "1 - graffiti & noise")
m = addCircleMarkers(m, 
                      lng=df_street_traffic_maint$lon_offset, lat=df_street_traffic_maint$lat_offset, 
                      popup=df_street_traffic_maint$Case_Type, 
                      radius=2, 
                      stroke = FALSE, fillOpacity = 0.75,
                      color = colorFactors(df_street_traffic_maint$cid),
                      group = "2 - street & traffic & maintenance")
m = addCircleMarkers(m, 
                      lng=df_garbage_recycling_organics$lon_offset, lat=df_garbage_recycling_organics$lat_offset, 
                      popup=df_garbage_recycling_organics$Case_Type, 
                      radius=2, 
                      stroke = FALSE, fillOpacity = 0.75,
                      color = colorFactors(df_garbage_recycling_organics$cid),
                      group = "3 - garbage related")
m = addCircleMarkers(m, 
                      lng=df_water$lon_offset, lat=df_water$lat_offset, 
                      popup=df_water$Case_Type, 
                      radius=2, 
                      stroke = FALSE, fillOpacity = 0.75,
                      color = colorFactors(df_water$cid),
                      group = "4 - water related")
m = addCircleMarkers(m, 
                      lng=df_animal_vegetation$lon_offset, lat=df_animal_vegetation$lat_offset, 
                      popup=df_animal_vegetation$Case_Type, 
                      radius=2,
                      stroke = FALSE, fillOpacity = 0.75,
                      color = colorFactors(df_animal_vegetation$cid),
                      group = "5 - animals & vegetation")
m = addCircleMarkers(m, 
                      lng=df_other$lon_offset, lat=df_other$lat_offset, 
                      popup=df_other$Case_Type, 
                      radius=2,
                      stroke = FALSE, fillOpacity = 0.75,
                      color = colorFactors(df_other$cid),
                      group = "0 - other")

m = addLayersControl(m,
                     baseGroups = c("Toner Lite","Toner"),
                     overlayGroups = c("1 - graffiti & noise", "2 - street & traffic & maintenance",
                                    "3 - garbage related","4 - water related", "5 - animals & vegetation",
                                    "0 - other")
)

# make the map
print(m)


# --------------- Second leaflet map --------------- #
# subset out your data_filter:
df_graffiti_noise = subset(data_filter, cid == 1)
df_street_traffic_maint = subset(data_filter, cid == 2)
df_garbage_recycling_organics = subset(data_filter, cid == 3)
df_water = subset(data_filter, cid == 4)
df_animal_vegetation = subset(data_filter, cid == 5)
df_other = subset(data_filter, cid == 0)

data_filterlist = list(df_graffiti_noise = subset(data_filter, cid == 1),
                df_street_traffic_maint = subset(data_filter, cid == 2),
                df_garbage_recycling_organics = subset(data_filter, cid == 3),
                df_water = subset(data_filter, cid == 4),
                df_animal_vegetation = subset(data_filter, cid == 5),
                df_other = subset(data_filter, cid == 0))
layerlist = c("1 - graffiti & noise", "2 - street & traffic & maintenance",
              "3 - garbage related","4 - water related", "5 - animals & vegetation",
              "0 - other")

colorFactors = colorFactor(c('red', 'orange', 'purple', 'blue', 'pink', 'brown'), domain=data_filter$cid)
for (i in 1:length(data_filterlist)){
  m = addCircleMarkers(m, 
                       lng=data_filterlist[[i]]$lon_offset,
                       lat=data_filterlist[[i]]$lat_offset, 
                       popup=data_filterlist[[i]]$Case_Type, 
                       radius=2,
                       stroke = FALSE, 
                       fillOpacity = 0.75,
                       color = colorFactors(data_filterlist[[i]]$cid),
                       group = layerlist[i]
  )
  
}
m = addTiles(m, "Stamen.TonerLite", group = "Toner Lite") 
m = addLayersControl(m,
                      overlayGroups = c("Toner Lite"),
                      baseGroups = layerlist
                      )
m


# --------------- Third leaflet map --------------- #
library(rgdal)
library(GISTools)
hex_1401_fn = '/Users/Jozo/Projects/Github-local/Workshop/aloha-r/data/calls_2014/shp/hgrid_250m_1401_counts.geojson'
hex_1401 = readOGR(hex_1401_fn, "OGRGeoJSON")

m = leaflet()
# m = addTiles(m) 
m = addProviderTiles(m, "Stamen.TonerLite", group = "Toner Lite") 

# Create a continuous palette function
pal = colorNumeric(
  palette = "Greens",
  domain = hex_1401$data
)



m = addPolygons(m, 
                data = hex_1401,
                stroke = FALSE, 
                smoothFactor = 0.2, 
                fillOpacity = 1,
                color = ~pal(hex_1401$data),
                popup= paste("Number of calls: ",hex_1401$data, sep="")
)
m = addLegend(m, "bottomright", pal = pal, values = hex_1401$data,
              title = "3-1-1 call density",
              labFormat = labelFormat(prefix = " "),
              opacity = 0.75
)
m 


# --------------- Last leaflet map --------------- #
library(rgdal)
library(GISTools)

# initiate leaflet map layer
m = leaflet()
m = addProviderTiles(m, "Stamen.TonerLite", group = "Toner Lite") 


# --- hex grid --- #
# store the file name of the geojson hex grid
hex_1401_fn = '/Users/Jozo/Projects/Github-local/Workshop/aloha-r/data/calls_2014/shp/hgrid_250m_1401_counts.geojson'

# read in the data
hex_1401 = readOGR(hex_1401_fn, "OGRGeoJSON")

# Create a continuous palette function
pal = colorNumeric(
  palette = "Greens",
  domain = hex_1401$data
)

# add hex grid
m = addPolygons(m, 
                data = hex_1401,
                stroke = FALSE, 
                smoothFactor = 0.2, 
                fillOpacity = 1,
                color = ~pal(hex_1401$data),
                popup= paste("Number of calls: ",hex_1401$data, sep=""),
                group = "hex"
)

# add legend
m = addLegend(m, "bottomright", pal = pal, values = hex_1401$data,
              title = "3-1-1 call density",
              labFormat = labelFormat(prefix = " "),
              opacity = 0.75
)

# --- points data --- #

# subset out your data:
df_graffiti_noise = subset(data_filter, cid == 1)
df_street_traffic_maint = subset(data_filter, cid == 2)
df_garbage_recycling_organics = subset(data_filter, cid == 3)
df_water = subset(data_filter, cid == 4)
df_animal_vegetation = subset(data_filter, cid == 5)
df_other = subset(data_filter, cid == 0)

data_filterlist = list(df_graffiti_noise = subset(data_filter, cid == 1),
                       df_street_traffic_maint = subset(data_filter, cid == 2),
                       df_garbage_recycling_organics = subset(data_filter, cid == 3),
                       df_water = subset(data_filter, cid == 4),
                       df_animal_vegetation = subset(data_filter, cid == 5),
                       df_other = subset(data_filter, cid == 0))
layerlist = c("1 - graffiti & noise", "2 - street & traffic & maintenance",
              "3 - garbage related","4 - water related", "5 - animals & vegetation",
              "0 - other")


colorFactors = colorFactor(c('red', 'orange', 'purple', 'blue', 'pink', 'brown'), domain=data_filter$cid)
for (i in 1:length(data_filterlist)){
  m = addCircleMarkers(m, 
                       lng=data_filterlist[[i]]$lon_offset, lat=data_filterlist[[i]]$lat_offset, 
                       popup=data_filterlist[[i]]$Case_Type, 
                       radius=2,
                       stroke = FALSE, fillOpacity = 0.75,
                       color = colorFactors(data_filterlist[[i]]$cid),
                       group = layerlist[i]
  )
  
}


m = addLayersControl(m,
                     overlayGroups = c("Toner Lite", "hex"),
                     baseGroups = layerlist
)

# show map
print(m)

