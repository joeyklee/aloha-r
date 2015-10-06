######################################################
# Vancouver 3-1-1: Data Processing Script
# Date:
# By: 
# Desc: 
######################################################


# ------------------------------------------------- #
# --------------- Install Libararies --------------- #
# ------------------------------------------------- #
install.packages("GISTools")
install.packages('rgdal')
install.packages('curl')
install.packages("devtools")
devtools::install_github("corynissen/geocodeHERE")

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
# ------------------- Acquire --------------------- #
# ------------------------------------------------- #
# access from the interwebz using "curl"
fname = curl('https://raw.githubusercontent.com/joeyklee/aloha-r/master/data/calls_2014/201401CaseLocationsDetails.csv')
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
ofile ='/Users/Jozo/Desktop/van311-1401-geo.csv' 
write.csv(data, ofile)
