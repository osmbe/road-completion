#!/bin/sh

FILENAME="Wegenregister_SHAPE_20200917"

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

node "../../../script/convert-tags.js" "./convert/Wegsegment.geojson" "WegsegmentTagged.geojson"