#!/bin/sh

FILENAME="Wegenregister_SHAPE_20200917"

# Make script directory working directory

cd `dirname "$(realpath $0)"`

# Download & unzip data

mkdir -p "./source/"

if [ ! -d "./source/$FILENAME" ]; then
  wget -O "./source/$FILENAME.zip" "https://downloadagiv.blob.core.windows.net/wegenregister/$FILENAME.zip"
  unzip "./source/$FILENAME.zip" -d "./source/$FILENAME/"
fi

# Convert to GeoJSON

if [ -d "./convert" ]; then rm -r "./convert/"; fi

mkdir -p "./convert/"

ogr2ogr -f "GeoJSON" -progress \
  --config SHAPE_ENCODING "ISO-8859-1" \
  -s_srs "EPSG:31370" -t_srs "EPSG:4326" \
  -sql "@filter.sql" \
  -lco COORDINATE_PRECISION=6 \
  "./convert/Wegsegment.geojson" \
  "./source/$FILENAME/Shapefile/Wegsegment.shp"

# Convert fields to OpenStreetMap tags

node "../../../script/convert-tags.js" -c "./convert.json" "./convert/Wegsegment.geojson" "WegsegmentTagged.geojson"

# Generate buffer

node "../../../script/buffer.js" "./convert/WegsegmentTagged.geojson" "WegsegmentBuffer.geojson"

# Generate vector tiles

if [ -d "./process" ]; then rm -r "./process/"; fi

mkdir -p "./process/"

tippecanoe --force --no-feature-limit --no-tile-size-limit \
  --maximum-zoom=14 --minimum-zoom=14 \
  --output="./process/WegsegmentTagged.mbtiles" "./convert/WegsegmentTagged.geojson" --layer="roads"
# tippecanoe --force --no-feature-limit --no-tile-size-limit \
#   --maximum-zoom=14 --minimum-zoom=14 \
#   --output="./process/WegsegmentBuffer.mbtiles" "./convert/WegsegmentBuffer.geojson" --layer="buffers"

# Difference

node "../../../script/difference.js" "./process/WegsegmentTagged.mbtiles" "../belgium-buffers.mbtiles"
