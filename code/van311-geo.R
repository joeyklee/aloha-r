# Install libaries:
# install.packages("GISTools")
# install.packages('rgdal')
# install.packages("ggmap")
# install.packages("devtools")
# devtools::install_github("hrbrmstr/nominatim")

# Add libraries:
library(GISTools)
library(rgdal)
library(ggmap)
# library(nominatim)

# --------------- Acquire --------------------- #
# read in data
fpath = '/Users/Jozo/Projects/Github-local/Workshop/aloha-r/data/CaseLocationsDetails_2014_CSV/201401/'
fname = '/Users/Jozo/Projects/Github-local/Workshop/aloha-r/data/CaseLocationsDetails_2014_CSV/201401CaseLocationsDetails-geo.csv'
# data = read.csv(fname, header=T, fileEncoding="UCS-2LE")
data = read.csv(fname, header=T)

# --------------- Parse --------------------- #
# --------------- Geocode the events ---------------- #
# change intersection to 00's
# data$h_block = gsub("#", "0", data$Hundred_Block)

# Join the strings from each column together & add "Vancouver, BC":
# data$full_address = paste(data$h_block, paste(data$Street_Name,
#                                               "Vancouver, BC, Canada",
#                                               sep=", "))

# OSM geocoder
# http://www.r-bloggers.com/introducing-the-nominatim-geocoding-package/
# test =osm_geocode('2200, SW MARINE DRIVE,  Kerrisdale, Vancouver, BC', limit=20)

# google geocoder
# geocode('2200, SW MARINE DRIVE,  Kerrisdale, Vancouver, BC', output= "latlon", source="google")

# coords_1_2500 = geocode(data$full_address[1:2500], 
#                         output= "latlon", 
#                         source="google")
# # write.csv(coords_1_2500, file = paste(fpath,'coords_1_2500.csv',sep=""))
# coords_2501_5000 = geocode(data$full_address[2501:5000], 
#                            output= "latlon", 
#                            source="google")
# # write.csv(coords_2501_5000, file = paste(fpath,'coords_2501_5000.csv',sep=""))
# coords_5001_7500 = geocode(data$full_address[5001:7500], 
#                            output= "latlon", 
#                            source="google")
# # write.csv(coords_5001_7500, file = paste(fpath,'coords_5001_7500.csv',sep=""))
# coords_7501_10000 = geocode(data$full_address[7501:10000], 
#                             output= "latlon", 
#                             source="google")
# # write.csv(coords_7501_10000, file = paste(fpath,'coords_7501_10000.csv',sep=""))
# coords_10001_10195 = geocode(data$full_address[10001:10195], 
#                              output= "latlon", 
#                              source="google")
# # write.csv(coords_10001_10195, file = paste(fpath,'coords_10001_10195.csv',sep=""))
# 
# # paste strings together in column for geoparsing
# coords_all=rbind(coords_1_2500, coords_2501_5000, coords_5001_7500, coords_7501_10000, coords_10000_10195)
# 
# # merge the data with the coordinates:
# geo_data = cbind(data, coords_all)

# API key: 6556c0b67a006a1f8ab4c37b1e3fb8fcb3a0e8e3 
# --------------- Mine --------------------- #
# Examine the unique cases
unique(data$Case_Type)
for (i in 1:length(unique(data$Case_Type))){
  print(unique(data$Case_Type)[i], max.levels=0)
}

# Determine classes to group case types:
graffiti_noise = c('Graffiti Removal - City Property','Graffiti Removal - External Organization','PUI Noise Complaint Case','PUI Noise General Inquiry Case')
street_traffic_maint = c('Street Furniture Repair and Maintenance Request','Street Cleaning & Debris Pickup','Street Light - Out','Street Tree Work Request SR','Street Litter Can Request','Streets - General Issues','Street Light - Pole Repair','Street - Surface Water Flooding','Street - Repair','Street Light - New/Relocation','Street Light - Flat Glass Fixture Request','Street and Traffic Light - Utility Damage','Street Sign - New','Crosswalk Marking - New','Boulevard Maintenance Issues','Bicycle Route Map Request','Sidewalk - Repair','Pothole - Repair','Pavement Markings Request - New/Modify','Pavement Marking - Repair','Sewer Pipe Inquiries','Sewer Manhole Issues','Sewer General Inquiries','Sewer Design General Inquiries','Sewer Separation Inspection Cancellation Case','Sewer Utility Damage','Sewer Odour Complaints','Plumbing and Gas Inspection Cancellation Case','Snow Angel Program - Individual Volunteer','Snow & Ice Removal - City Property','Snow and Ice Removal - Sidewalk Bylaw Violation','Snow and Ice Removal - Sidewalk Bylaw Inquiry','Traffic & Pedestrian Signal - New','Traffic Calming Request','Traffic & Pedestrian Signal - Modify','Traffic Sign - Modify','Street and Traffic Light - Utility Damage','Traffic Sign - New','Traffic Count Request','Truck Violation','Residential Parking Requests','Parking Meter Requests','Abandoned Vehicle Request')
garbage_recycling_organics = c('Missed Garbage Pickup','Abandoned Garbage Pickup - City Property & Parks','Cart - Garbage','Illegal Dumping/Abandoned Garbage Pickup','Parks Litter Can or Cart Request','Recycling Bag Request','Missed Recycling Pickup','Missed Apartment Recycling Pickup','Recycling Box Request','Cart - Apartment Recycling','Apartment Recycling - Registration Request','Transfer Station & Recycling - General Inquiries','Blue Box and Leaf Removal Guide Mail-Out Request','Missed Yard Trimmings and Food Scraps Pickup','Cart - Green (Yard Trimmings and Food Scraps)','Green Bin Program - Feedback and General Inquiry','Collection Calendar Mail-Out Request')
water = c('Water Leaks/Breaks','Water Service Turn On/Off Request','Water Service Locate Request','Street - Surface Water Flooding','Water Work Site Complaint','Water Hydrant Issue','Water General Inquiry','Water General Work Request','Water Pressure or No Water Issue','Water Conservation Violation','Water Meter Issue','Water Damage To City Water System','Catch Basin Issues')
animal_vegetation = c('Dead Animal Pickup Case','Animal Control General Inquiry Case','Animal Complaint - Non-Emergency Case','Animal Cremation Case','Dead Skunk Pickup','Lost Pets Case','Holding Stray Case','Chafer Beetle Feedback','Vegetation Maintenance SR','Trees and Vegetation Encroachment - City Property','Horticulture Inquiry on Right-of-Way')
other = c('Poster/Sign Removal Request','Sign - Repair','Curbside Sign - New','Curbside Sign - Modify','Banner Request','Fire Reinspection Request for Firehall','Fire Reinspection Request for Inspector','Citizen Feedback','Wheelchair Curb/Ramp Request','Wheelchair','PRB_Park Ranger SR','Building Plans Information Request','Building Inspection Cancellation Case','Licence Payment Request Case','Gone Out of Business Case','FPB_General Inquiry Case','PUI General Inquiry Case','Electrical Inspection Cancellation Case','Bridges & Structures - Repair','Secondary Suite Information Request','General Information Request SR','Election General Concerns','Occupancy Permit Information Request','Home Safety Check Request Case','Flag Request','Homelessness/Transient Issue')

# give class id numbers:
data$cid = 9999
for(i in 1:length(data$Case_Type)){
  if(data$Case_Type[i] %in% graffiti_noise){
    data$cid[i] = 1    
  }else if(data$Case_Type[i] %in% street_traffic_maint){
    data$cid[i] = 2   
  }else if(data$Case_Type[i] %in% garbage_recycling_organics){
    data$cid[i] = 3   
  }else if(data$Case_Type[i] %in% water){
    data$cid[i] = 4   
  }else if(data$Case_Type[i] %in% animal_vegetation){
    data$cid[i] = 5   
  }else{
    data$cid[i] = 0   
  }
}

# Set offset for points in same location:
data$lat_offset = data$lat
data$lon_offset = data$lon
# Run loop - if value overlaps, offset it by a random number
for(i in 1:length(data$lat)){
  if ( (data$lat_offset[i] %in% data$lat_offset) && (data$lon_offset[i] %in% data$lon_offset)){
    data$lat_offset[i] = data$lat_offset[i] + runif(1, 0.00003, 0.00005)
    data$lon_offset[i] = data$lon_offset[i] + runif(1, 0.00003, 0.00005)
  } 
}

# write.csv(data, '/Users/Jozo/Projects/Github-local/Workshop/aloha-r/data/CaseLocationsDetails_2014_CSV/201401CaseLocationsDetails-geo-temp.csv')

# plot(data$lon_offset, data$lat_offset, xlim=c(-123.26, -123.0), 
#      ylim = c(49.2, 49.3), col=rgb(0,0,1,0.5))
# points(data$lon, data$lat, xlim=c(-123.26, -123.0), 
#      ylim = c(49.2, 49.3), col=rgb(1,0,0,0.5))

# get a frequency distribution of the calls:
# test = data.frame(table(data$Case_Type))
# test = test[order(test$Freq),]
# test


# remove any values not within bounds & NA's:
data_filter = subset(data, (lat <= 49.3) | (lat >= 49.2) & (lon <= -123) | (lon >= -123.1) & is.na(lon) )

# convert table to shp
coords_311 = data.frame(data_filter$lon_offset, data_filter$lat_offset)
data_spatial = SpatialPointsDataFrame(coords = coords_311, data = data_filter)
projection_wgs84 = CRS("+proj=longlat +datum=WGS84")
proj4string(data_spatial) = projection_wgs84
writeOGR(data_spatial, "/Users/Jozo/Projects/Github-local/Workshop/aloha-r/data/shp/",'calls_1401',  driver="ESRI Shapefile")

# ------ get total counts ------ #
# http://stackoverflow.com/questions/17801398/counting-species-occurrence-in-a-grid
# http://www.inside-r.org/packages/cran/GISTools/docs/poly.counts
grid_fn = '/Users/Jozo/Projects/Github-local/Workshop/aloha-r/data/shp/hgrid_100m.shp'
projection_utm10n = CRS('+proj=utm +zone=10 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs')
hexgrid = readShapeSpatial(grid_fn, proj4string = projection_utm10n )
hexgrid_wgs84 = spTransform(hexgrid, projection_wgs84)
head(hexgrid_wgs84)

grid_cnt = poly.counts(data_spatial, hexgrid_wgs84)
grid_total_counts = data.frame(grid_cnt)

hexgrid_wgs84$data = grid_total_counts$grid_cnt

# shades = auto.shading(hexgrid_wgs84$data,cols=brewer.pal(5,'Reds'))
# choropleth(hexgrid_wgs84, hexgrid_wgs84$data, shading = auto.shading(hexgrid_wgs84$data))
# help(choropleth)

# writeSpatialShape(hexgrid_wgs84, "/Users/Jozo/Projects/Github-local/Workshop/aloha-r/data/shp/hgrid_100m-temp.shp")


# ---- but let's join them at the block scale --- #
blocks_fn = '/Users/Jozo/Projects/Github-local/Workshop/aloha-r/data/shp/blocks_wgs84.shp'
blocks = readShapeSpatial(blocks_fn)

hubpoints_fn = '/Users/Jozo/Projects/Github-local/Workshop/aloha-r/data/shp/calls-1401-hubs.shp'
hubpoints = readShapeSpatial(hubpoints_fn)
hubpoints@data$cnt = 1

# aggregate the hubpoints by the "HubName"
hubpoints_aggregated = aggregate(hubpoints$cnt, by=list(Category=hubpoints$HubName), FUN=sum)

# join the data together
block_totals = merge(x = blocks, y = hubpoints_aggregated, by.x = "guid", by.y = "Category", all.x=T)
writeSpatialShape(block_totals, "/Users/Jozo/Projects/Github-local/Workshop/aloha-r/data/shp/block-totals-1401.shp")
# join to neighborhood scale

# join to grid (http://stackoverflow.com/questions/29374004/how-do-i-generate-a-hexagonal-grid-in-r)


# we will apply our script to all the csv's in the folder, then merge