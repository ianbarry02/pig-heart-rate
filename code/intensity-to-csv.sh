# Code from Pearce Barry 2023

#/usr/vin/env bash

# The following script will convert a 2 column table of "index intensity" row
# values (separated by a single space) to a 3-column CSV file containing
# "index,timestamp,intensity" values per row.

# Open a macOS terminal, cd to the Dowloads directory (or wherever this script
# is saved) and run this script as such:
#
# ./intensity-to_csv.sh < data-file > csv-file
#
# Where "data-file" above is the name of the file of "index intensity" table
# data, and "csv-file" is the name of the output CSV file it should create.
#
# Example: my table data is in a file called "mydata.txt" and I want a CSV file
# created called "collected-data.csv", then I would run the following command:
#
# ./intensity-to_csv.sh < mydata.txt > collected-data.csv

# Set the following variable to the number of frames per second of the video so
# that the timestamp-per-frame gets cacluated correctly.
FRAMES_PER_SECOND=30

# How many milliseconds between frames
TIMESTAMP_INTERVAL_MS=$((1000 / 30))
TIMESTAMP=0

#Print the CSV header row (comment this out if you don't want/need one)
echo "Index,Time Stamp (s),Intensity"
while read -r LINE; do
	INDEX=$(echo ${LINE} | sed 's/[ \t].*$//')
	INTENSITY=$(echo ${LINE} | sed 's/^.*[ \t]//')
	TIMESTAMP_IN_S=$(echo "scale=3; ${TIMESTAMP} / 1000" | bc)
	echo ${INDEX},${TIMESTAMP_IN_S},${INTENSITY}
	TIMESTAMP=$((TIMESTAMP + TIMESTAMP_INTERVAL_MS))
done
