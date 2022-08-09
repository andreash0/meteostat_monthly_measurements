from meteostat import Stations, Monthly
from datetime import datetime

# Set time period
start = datetime(2000, 1, 1)
end = datetime(2021, 12, 31)

# Get Monthly data
stations_us = Stations().region('US').fetch()
idx_stations_us = stations_us.index.to_list()
monthly_data = Monthly(idx_stations_us, start, end)
monthly_data = monthly_data.fetch()

# Write to csv
monthly_data.to_csv("raw_data/monthly_data.csv")
stations_us.index.names = ['station']
stations_us.to_csv("raw_data/stations_meta.csv")
