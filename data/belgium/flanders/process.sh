#!/bin/sh

FILENAME="Wegenregister_SHAPE_20250130"
MAPROULETTE_CHALLENGE=24090

# Make script directory working directory

cd `dirname "$(realpath $0)"`

# Download & unzip data

mkdir -p "./source/"

if [ ! -d "./source/$FILENAME" ]; then
  wget -O "./source/$FILENAME.zip" "https://download.vlaanderen.be/bff/v1/Orders/480308/download/f5caa4db-9ad9-4464-bcea-96ec997c488e"
  unzip -j "./source/$FILENAME.zip" -d "./source/$FILENAME/" "$FILENAME/Shapefile/Wegsegment.*"
fi

# Convert to GeoJSON

if [ -d "./temp" ]; then rm -r "./temp/"; fi

mkdir -p "./temp/"

ogr2ogr -f "GeoJSON" -progress \
  --config SHAPE_ENCODING "ISO-8859-1" \
  -s_srs "EPSG:31370" -t_srs "EPSG:4326" \
  -sql "@filter.sql" \
  -lco COORDINATE_PRECISION=6 \
  -fieldTypeToString "All" \
  "./temp/Wegsegment.geojson" \
  "./source/$FILENAME/Wegsegment.shp"

# Convert fields to OpenStreetMap tags

node "../../../script/convert-tags.js" -c "./convert.json" "./temp/Wegsegment.geojson" "WegsegmentTagged.geojson"

# Generate vector tiles

tippecanoe --force --no-feature-limit --no-tile-size-limit \
  --buffer=0 \
  --maximum-zoom=14 --minimum-zoom=14 \
  --layer="roads" \
  --output="./temp/WegsegmentTagged.mbtiles" "./temp/WegsegmentTagged.geojson"

# Generate MapRoulette NotAnIssue buffers vector tiles

wget -O "./temp/maproulette.geojson" "https://maproulette.org/api/v2/challenge/view/$MAPROULETTE_CHALLENGE?status=2"

node "../../../script/buffer.js" --radius=20 "./temp/maproulette.geojson" "maproulette-buffers.geojson"

# Merge MapRoulette buffers to OpenStreetMap buffers

tippecanoe --force --no-feature-limit --no-tile-size-limit \
  --maximum-zoom=14 --minimum-zoom=14 \
  --layer="buffers" \
  --output="./temp/belgium-buffers.mbtiles" \
  "../belgium-lines-buffers.geojson" "../belgium-polygons-buffers.geojson" "./temp/maproulette-buffers.geojson"

# Difference

if [ -d "./difference" ]; then rm -r "./difference/"; fi

mkdir -p "./difference"

node "../../../script/difference.js" --output-dir="./difference" "./temp/WegsegmentTagged.mbtiles" "./temp/belgium-buffers.mbtiles"
