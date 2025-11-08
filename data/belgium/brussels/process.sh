#!/bin/sh

MAPROULETTE_CHALLENGE=14675
URBIS_DATE="20251004"

# Make script directory working directory

cd `dirname "$(realpath $0)"`

# Download & unzip data

mkdir -p "./source/"

if [ ! -d "./source/UrbISVector" ]; then
  wget -O "./source/UrbISVector.zip" "https://urbisdownload.datastore.brussels/UrbIS/Vector/M8/UrbIS-Vector/GPKG/UrbISVector_31370_GPKG_04000_${URBIS_DATE}.zip"
  unzip "./source/UrbISVector.zip" -d "./source/UrbISVector/"
fi

# Convert to GeoJSON

if [ -d "./temp" ]; then rm -r "./temp/"; fi

mkdir -p "./temp/"

ogr2ogr -f "GeoJSON" -progress \
  -s_srs "EPSG:31370" -t_srs "EPSG:4326" \
  -sql "@filter.sql" \
  -lco COORDINATE_PRECISION=6 \
  -fieldTypeToString "All" \
  "./temp/StreetAxes.geojson" \
  "./source/UrbISVector/gpkg/UrbISVector_04000.gpkg" "StreetAxes"

# Convert fields to OpenStreetMap tags

node "../../../script/convert-tags.js" -c "./convert.json" "./temp/StreetAxes.geojson" "StreetAxesTagged.geojson"

# Generate vector tiles

tippecanoe --force --no-feature-limit --no-tile-size-limit \
  --buffer=0 \
  --maximum-zoom=14 --minimum-zoom=14 \
  --layer="roads" \
  --output="./temp/StreetAxesTagged.mbtiles" "./temp/StreetAxesTagged.geojson"

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

node "../../../script/difference.js" --output-dir="./difference" "./temp/StreetAxesTagged.mbtiles" "./temp/belgium-buffers.mbtiles"
