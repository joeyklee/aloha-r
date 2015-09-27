devtools::install_github("corynissen/geocodeHERE") 
library(geocodeHERE)

fake = data
lat = c()
lon = c()
for(i in 1: length(data$full_address)){
  address = as.character(fake$full_address[i])
  lat = c(lat,geocodeHERE_simple(address)$Latitude)
  lon = c(lon,geocodeHERE_simple(address)$Longitude)
  print(paste(lat[i], lon[i], sep=","))
}

