# Install libaries:
# install.packages("GISTools")
# install.packages("ggmap")
# install.packages("devtools")
# devtools::install_github("hrbrmstr/nominatim")

# Add libraries:
library(GISTools)
library(ggmap)
# library(nominatim)

# --------------- Acquire --------------------- #
# read in data
fpath = '/Users/Jozo/Projects/Github-local/Workshop/aloha-r/data/CaseLocationsDetails_2014_CSV/201401/'
fname = '/Users/Jozo/Projects/Github-local/Workshop/aloha-r/data/CaseLocationsDetails_2014_CSV/201401CaseLocationsDetails.csv'
data = read.csv(fname, header=T, fileEncoding="UCS-2LE")

# --------------- Parse --------------------- #
# --------------- Geocode the events ---------------- #
# change intersection to 00's
data$h_block = gsub("#", "0", data$Hundred_Block)

# Join the strings from each column together & add "Vancouver, BC":
data$full_address = paste(data$h_block, paste(data$Street_Name, 
                          data$Local_Area,
                          "Vancouver, BC",
                          sep=", "))

# OSM geocoder
# http://www.r-bloggers.com/introducing-the-nominatim-geocoding-package/
# test =osm_geocode('2200, SW MARINE DRIVE,  Kerrisdale, Vancouver, BC', limit=20)

# google geocoder
# geocode('2200, SW MARINE DRIVE,	Kerrisdale, Vancouver, BC', output= "latlon", source="google")

coords_1_2500 = geocode(data$full_address[1:2500], 
                 output= "latlon", 
                 source="google")
# write.csv(coords_1_2500, file = paste(fpath,'coords_1_2500.csv',sep=""))
coords_2501_5000 = geocode(data$full_address[2501:5000], 
                        output= "latlon", 
                        source="google")
# write.csv(coords_2501_5000, file = paste(fpath,'coords_2501_5000.csv',sep=""))
coords_5001_7500 = geocode(data$full_address[5001:7500], 
                           output= "latlon", 
                           source="google")
# write.csv(coords_5001_7500, file = paste(fpath,'coords_5001_7500.csv',sep=""))
coords_7501_10000 = geocode(data$full_address[7501:10000], 
                           output= "latlon", 
                           source="google")
# write.csv(coords_7501_10000, file = paste(fpath,'coords_7501_10000.csv',sep=""))
coords_10001_10195 = geocode(data$full_address[10001:10195], 
                            output= "latlon", 
                            source="google")
# write.csv(coords_10001_10195, file = paste(fpath,'coords_10001_10195.csv',sep=""))

# paste strings together in column for geoparsing
coords_all=rbind(coords_1_2500, coords_2501_5000, coords_5001_7500, coords_7501_10000, coords_10000_10195)

# merge the data with the coordinates:
geo_data = cbind(data, coords_all)


# --------------- Mine --------------------- #
# create code for complaints >, <, etc. 


# Join block scale 

# join to neighborhood scale

# join to grid

# 


# we will apply our script to all the csv's in the folder, then merge