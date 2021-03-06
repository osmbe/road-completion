#!/bin/sh

FILENAME="01-12-2020"
MAPROULETTE_CHALLENGE=17332

# Make script directory working directory

cd `dirname "$(realpath $0)"`

# Download & unzip data

mkdir -p "./source/"

if [ ! -d "./source/$FILENAME" ]; then
  wget -O "./source/$FILENAME.zip" "https://www.rijkswaterstaat.nl/apps/geoservices/geodata/dmc/nwb-wegen/geogegevens/shapefile/Nederland_totaal/$FILENAME.zip"
  unzip -j "./source/$FILENAME.zip" -d "./source/$FILENAME/" "$FILENAME/Wegvakken/Wegvakken.*"
fi

# Convert to GeoJSON

if [ -d "./temp" ]; then rm -r "./temp/"; fi

mkdir -p "./temp/"

ogr2ogr -f "GeoJSON" -progress \
  --config SHAPE_ENCODING "ISO-8859-1" \
  -s_srs "EPSG:28992" -t_srs "EPSG:4326" \
  -sql "@filter.sql" \
  -lco COORDINATE_PRECISION=6 \
  -fieldTypeToString "All" \
  "./temp/Wegvakken.geojson" \
  "./source/$FILENAME/Wegvakken/Wegvakken.shp"

# Convert fields to OpenStreetMap tags

node "../../../script/convert-tags.js" -c "./convert.json" "./temp/Wegvakken.geojson" "WegvakkenTagged.geojson"

# Generate vector tiles

tippecanoe --force --no-feature-limit --no-tile-size-limit \
  --buffer=0 \
  --maximum-zoom=14 --minimum-zoom=14 \
  --layer="roads" \
  --output="./temp/WegvakkenTagged.mbtiles" "./temp/WegvakkenTagged.geojson"

# Generate MapRoulette NotAnIssue buffers vector tiles

wget -O "./temp/maproulette.geojson" "https://maproulette.org/api/v2/challenge/view/$MAPROULETTE_CHALLENGE?status=2"

node "../../../script/buffer.js" --radius=20 "./temp/maproulette.geojson" "maproulette-buffers.geojson"

# Merge MapRoulette buffers to OpenStreetMap buffers

tippecanoe --force --no-feature-limit --no-tile-size-limit \
  --maximum-zoom=14 --minimum-zoom=14 \
  --layer="buffers" \
  --output="./temp/netherlands-buffers.mbtiles" \
  "netherlands-lines-buffers.geojson" "netherlands-polygons-buffers.geojson" "./temp/maproulette-buffers.geojson"

# Difference

if [ -d "./difference" ]; then rm -r "./difference/"; fi

mkdir -p "./difference"

node "../../script/difference.js" --output-dir="./difference" "./temp/WegvakkenTagged.mbtiles" "./temp/netherlands-buffers.mbtiles"
