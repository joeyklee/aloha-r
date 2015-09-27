######################################################
# Vancouver 3-1-1: Data Processing Script
# Date:
# By: 
# Desc: 
######################################################

# --------- Install Libararies --------- #
install.packages("GISTools")
install.packages('rgdal')
install.packages("devtools")
devtools::install_github("corynissen/geocodeHERE")

# Unused Libraries:
# install.packages("ggmap")
# library(ggmap)

# --------- Load Libararies --------- #
library(GISTools)
library(rgdal)
library(geocodeHERE)

# --------- Acquire --------- #
# read in data
fname = '/Users/Jozo/Projects/Github-local/Workshop/aloha-r/data/CaseLocationsDetails_2014_CSV/201401CaseLocationsDetails.csv'