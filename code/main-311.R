######################################################
# Vancouver 3-1-1: Data Processing Script
# Date:
# By: 
# Desc: 
######################################################

# ------------------------------------------------- #
# --------------- Install Libararies --------------- #
# ------------------------------------------------- #
# install.packages("GISTools")
# install.packages('rgdal')
# install.packages('curl')
# install.packages("devtools")
# devtools::install_github("corynissen/geocodeHERE")

# Unused Libraries:
# install.packages("ggmap")
# library(ggmap)

# ------------------------------------------------- #
# ---------------- Load Libararies ----------------- #
# ------------------------------------------------- #
library(GISTools)
library(rgdal)
library(geocodeHERE)
library(curl)

# ------------------------------------------------- #
# ---------------- Set File Vars ------------------ #
# ------------------------------------------------- #
# access from the interwebz using "curl"
fname = curl('https://raw.githubusercontent.com/joeyklee/aloha-r/master/data/calls_2014/201401CaseLocationsDetails.csv')
ofile ='/Users/Jozo/Projects/Github-local/Workshop/aloha-r/data/CaseLocationsDetails_2014_CSV/201401CaseLocationsDetails-geo.csv' 
yymm = 1401

# ------------------------------------------------- #
# ------------------- Acquire --------------------- #
# ------------------------------------------------- #
# # access from the interwebz using "curl"
# fname = curl('https://raw.githubusercontent.com/joeyklee/aloha-r/master/data/calls_2014/201401CaseLocationsDetails.csv')
# Read data as csv
data = read.csv(fname, header=T)
# inspect your data
print(head(data))

# ------------------------------------------------- #
# -------------- Parse: Geocoder ------------------- #
# ------------------------------------------------- #
# change intersection to 00's
data$h_block = gsub("#", "0", data$Hundred_Block)
print(head(data$h_block))

# Join the strings from each column together & add "Vancouver, BC":
data$full_address = paste(data$h_block, 
                          paste(data$Street_Name,
                                "Vancouver, BC, Canada",
                                sep=", "),
                          sep=" ")
data$full_address = gsub("Intersection", "", data$full_address)
print(data$full_address)

# Geocode the events - we use Nokia's Here API
# Create an empty vector for lat and lon coordinates
lat = c(); lon = c()
# loop through the addresses
for(i in 1: length(data$full_address)){
  # store the address at index "i" as a character
  address = as.character(data$full_address[i])
  # append the latitude of the geocoded address to the lat vector
  lat = c(lat,geocodeHERE_simple(address)$Latitude)
  # append the longitude of the geocoded address to the lon vector
  lon = c(lon,geocodeHERE_simple(address)$Longitude)
  # at each iteration through the loop, print the coordinates - takes about 20 min.
  print(paste("#",i,", ", lat[i], lon[i], sep=","))
}

# add the lat lon coordinates to the dataframe
data$lat = lat
data$lon = lon

# after geocoding, it's a good idea to write your file out!
# ofile ='/Users/Jozo/Projects/Github-local/Workshop/aloha-r/data/CaseLocationsDetails_2014_CSV/201401CaseLocationsDetails-geo.csv' 
write.csv(data, ofile)

# ------------------------------------------------- #
# --------------------- Mine ---------------------- #
# ------------------------------------------------- #
# --- Examine the unique cases --- #

# examine how the cases are grouped - are these intuitive?
unique(data$Department)
unique(data$Division)

# examine the types of cases - can we make new groups that are more useful?
unique(data$Case_Type)
# Print each unique case on a new line for easier inspection
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

# --- handle overlapping points --- #
# Set offset for points in same location:
data$lat_offset = data$lat
data$lon_offset = data$lon
# Run loop - if value overlaps, offset it by a random number
for(i in 1:length(data$lat)){
  if ( (data$lat_offset[i] %in% data$lat_offset) && (data$lon_offset[i] %in% data$lon_offset)){
    data$lat_offset[i] = data$lat_offset[i] + runif(1, 0.00005, 0.0001)
    data$lon_offset[i] = data$lon_offset[i] + runif(1, 0.00005, 0.0001)
  } 
}

# --- what are the top calls? --- #
# get a frequency distribution of the calls:
top_calls = data.frame(table(data$Case_Type))
top_calls = top_calls[order(top_calls$Freq),]
print(top_calls)


# ------------------------------------------------- #
# -------------------- Filter --------------------- #
# ------------------------------------------------- #
# set an output folder for our shapefiles
shpfolder = '/Users/Jozo/Projects/Github-local/Workshop/aloha-r/data/calls_2014/shp/'

# Subset only the data if the coordinates are within our bounds or if it is not a NA
data_filter = subset(data, (lat <= 49.3) | (lat >= 49.2) & 
                       (lon <= -123) | (lon >= -123.1) & is.na(lon) )

# --- Convert Data to Shapefile --- #
# store coordinates in dataframe
coords_311 = data.frame(data_filter$lon_offset, data_filter$lat_offset)
# create spatialPointsDataFrame
data_shp = SpatialPointsDataFrame(coords = coords_311, data = data_filter)
# set the projection to wgs84
projection_wgs84 = CRS("+proj=longlat +datum=WGS84")
proj4string(data_shp) = projection_wgs84
# write the file to a shp
# writeOGR(data_shp, 
#          shpfolder,
#          paste('calls_',yymm, sep=""),  driver="ESRI Shapefile")
writeOGR(data_shp, paste(shpfolder,'calls_',yymm, sep=""),layer='data_shp',  driver='GeoJSON')

# --- aggregate to a grid --- #
# ref: http://www.inside-r.org/packages/cran/GISTools/docs/poly.counts
# set the file name - combine the shpfolder with the name of the grid
# grid_fn = paste(shpfolder,'hgrid_100m.shp', sep="")
grid_fn = 'https://raw.githubusercontent.com/joeyklee/aloha-r/master/data/calls_2014/shp/hgrid_100m.geojson'
# define the utm 10n projection
# projection_utm10n = CRS('+proj=utm +zone=10 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs')
# read in the hex grid setting the projection to utm10n
# hexgrid = readShapeSpatial(grid_fn, proj4string = projection_utm10n )
hexgrid = readOGR(grid_fn, 'OGRGeoJSON')
# transform the projection to wgs84 to match the point file and store it to a new variable
hexgrid_wgs84 = spTransform(hexgrid, projection_wgs84)

# Use the poly.counts() function to count the number of occurences of calls per grid cell
grid_cnt = poly.counts(data_shp, hexgrid_wgs84)
# create a data frame of the counts
grid_total_counts = data.frame(grid_cnt)
# set grid_total_counts dataframe to the hexgrid data
hexgrid_wgs84$data = grid_total_counts$grid_cnt

# write the grid counts to a shp
# writeOGR(hexgrid_wgs84, 
#          shpfolder,
#          paste('hgrid_100m-',yymm,'-counts', sep=""),  driver="ESRI Shapefile")

writeOGR(hexgrid_wgs84, paste(shpfolder,'hgrid_100m_',as.character(yymm),'_counts', sep=""),layer='hexgrid_wgs84',  driver='GeoJSON')


