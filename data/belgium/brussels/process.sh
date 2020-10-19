#!/bin/sh

# Make script directory working directory

cd `dirname "$(realpath $0)"`

# Download & unzip data

mkdir -p "./source/"

if [ ! -d "./source/UrbAdm_SHP" ]; then
  wget -O "./source/UrbAdm_SHP.zip" "https://s.irisnet.be/v1/AUTH_ce3f7c74-fbd7-4b46-8d85-53d10d86904f/UrbAdm/UrbAdm_SHP.zip"
  unzip "./source/UrbAdm_SHP.zip" -d "./source/UrbAdm_SHP/" "shp/UrbAdm_STREET_AXIS.*"
fi

# Convert to GeoJSON

if [ -d "./temp" ]; then rm -r "./temp/"; fi

mkdir -p "./temp/"

ogr2ogr -f "GeoJSON" -progress \
  -s_srs "EPSG:31370" -t_srs "EPSG:4326" \
  -sql "@filter.sql" \
  -lco COORDINATE_PRECISION=6 \
  "./temp/UrbAdm_STREET_AXIS.geojson" \
  "./source/UrbAdm_SHP/shp/UrbAdm_STREET_AXIS.shp"

# Convert fields to OpenStreetMap tags

node "../../../script/convert-tags.js" -c "./convert.json" "./temp/UrbAdm_STREET_AXIS.geojson" "UrbAdm_STREET_AXISTagged.geojson"

# Generate vector tiles

tippecanoe --force --no-feature-limit --no-tile-size-limit \
  --buffer=0 \
  --maximum-zoom=14 --minimum-zoom=14 \
  --layer="roads" \
  --output="./temp/UrbAdm_STREET_AXISTagged.mbtiles" "./temp/UrbAdm_STREET_AXISTagged.geojson"

# Difference

if [ -d "./difference" ]; then rm -r "./difference/"; fi

mkdir -p "./difference"

node "../../../script/difference.js" --output-dir="./difference" "./temp/UrbAdm_STREET_AXISTagged.mbtiles" "../belgium-buffers.mbtiles"
