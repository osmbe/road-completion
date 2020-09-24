#!/bin/sh


# Download & unzip data

mkdir -p "./source/"

if [ ! -d "./source/UrbAdm_SHP" ]; then
  wget -O "./source/UrbAdm_SHP.zip" "https://s.irisnet.be/v1/AUTH_ce3f7c74-fbd7-4b46-8d85-53d10d86904f/UrbAdm/UrbAdm_SHP.zip"
  unzip "./source/UrbAdm_SHP.zip" -d "./source/UrbAdm_SHP/"
fi

# Convert to GeoJSON

if [ -d "./convert" ]; then rm -r "./convert/"; fi

mkdir -p "./convert/"

ogr2ogr -f "GeoJSON" -progress \
  -s_srs "EPSG:31370" -t_srs "EPSG:4326" \
  -sql "@filter.sql" \
  -lco COORDINATE_PRECISION=6 \
  "./convert/UrbAdm_STREET_AXIS.geojson" \
  "./source/UrbAdm_SHP/shp/UrbAdm_STREET_AXIS.shp"

# ogr2ogr -f "GeoJSON" -progress \
#   -s_srs "EPSG:31370" -t_srs "EPSG:4326" \
#   -sql "@filter.sql" \
#   -lco COORDINATE_PRECISION=6 \
#   "./convert/UrbAdm_STREET_SURFACE_LEVEL0.geojson" \
#   "./source/UrbAdm_SHP/shp/UrbAdm_STREET_SURFACE_LEVEL0.shp"

# Convert fields to OpenStreetMap tags

node "../../../script/convert-tags.js" "./convert/UrbAdm_STREET_AXIS.geojson" "UrbAdm_STREET_AXISTagged.geojson"

# Generate buffer

node "../../../script/buffer.js" "./convert/UrbAdm_STREET_AXISTagged.geojson" "UrbAdm_STREET_AXISBuffer.geojson"
