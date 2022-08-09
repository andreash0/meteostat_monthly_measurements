library(sp)
library(rgdal)
library(dplyr)

stations_meta <- read.csv("raw_data/stations_meta.csv")
monthly_data <- read.csv("raw_data/monthly_data.csv")
counties <- readRDS("usa2.RDS")

# Derive state and county from lon and lat of weather stations
stations_points <- SpatialPoints(stations_meta[, c("longitude", "latitude")])
proj4string(counties) <- proj4string(stations_points)
stations_meta$State <- over(stations_points, counties) %>% pull(NAME_1) %>% as.character()
stations_meta$County <- over(stations_points, counties) %>% pull(NAME_2) %>% as.character()

meteostat_monthly <- monthly_data %>% left_join(stations_meta, by = "station")
write.csv(meteostat_monthly, "meteostat_monthly.csv")
