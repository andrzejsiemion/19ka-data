#!/bin/bash

### set variables
# day for filename 
current_day=$(date +"%Y-%m-%d")

# clock time for measurment
current_time=$(date +"%H:%M:%S")

# set pin phere dht is set
DHT_PIN=4

# Read the temperature and humidity from the DHT22 sensor
#data=$(sudo /usr/bin/python3 -c "import Adafruit_DHT; print(Adafruit_DHT.read_retry(Adafruit_DHT.DHT22, $DHT_PIN))")
data=$(sudo /usr/bin/python3 -c "import Adafruit_DHT; print(Adafruit_DHT.read_retry(Adafruit_DHT.AM2302, $DHT_PIN))")

# debug purposes
#echo "data: $data"

# extract temp and humidity from data
temp=$(echo "$data" | sed 's/.*, \(.*\))/\1/')
hum=$(echo "$data" | sed 's/.*(\([^,]*\),.*/\1/')

# round values to 2 decimal points
rounded_temp=$(printf "%.2f" "$temp")
rounded_hum=$(printf "%.2f" "$hum")

# Print the extracted values
#echo "Temperature: $temp"
#echo "Humidity: $hum"

# check if file exist and create it if not
if [ ! -f "$current_day.csv" ]; then
	touch "$current_day.csv"
	echo "date,time,temperature,humidity" >> "$current_day.csv"
fi

# full values
echo "$current_day,$current_time,$temp,$hum" >> "$current_day.csv"

# rounded values
# echo "$current_day,$current_time,$rounded_temp,$rounded_hum" >> "$current_day.csv"
