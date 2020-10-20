#!/bin/sh

FILENAME="transport-et-voies-de-communication-shape"
MAPROULETTE_CHALLENGE=17749

# Make script directory working directory

cd `dirname "$(realpath $0)"`

# Download & unzip data

mkdir -p "./source/"

if [ ! -d "./source/$FILENAME" ]; then
  wget -O "./source/$FILENAME.zip" "https://data.public.lu/fr/datasets/r/e74aadad-77c2-441e-98fe-e08a441484a2"
  unzip -j "./source/$FILENAME.zip" -d "./source/$FILENAME/" "TRP_VC.*"
fi

# Convert to GeoJSON

if [ -d "./temp" ]; then rm -r "./temp/"; fi

mkdir -p "./temp/"

ogr2ogr -f "GeoJSON" -progress \
  --config SHAPE_ENCODING "ISO-8859-1" \
  -s_srs "EPSG:2169" -t_srs "EPSG:4326" \
  -sql "@filter.sql" \
  -lco COORDINATE_PRECISION=6 \
  -fieldTypeToString "All" \
  "./temp/trpvc.geojson" \
  "./source/$FILENAME/TRP_VC.shp"


# Before conferting the fields into OpenStreetMap tags, we extend convert.json with our street name standardization
# Download our community-driven street name standardization tuples

wget -O "./temp/csventrifuge_enhance_name.csv" "https://raw.githubusercontent.com/osmlu/csventrifuge/master/rules/luxembourg_addresses/rue.csv"
wget -O "./temp/csventrifuge_enhance_id.csv" "https://raw.githubusercontent.com/osmlu/csventrifuge/master/enhance/luxembourg_addresses/id_caclr_rue/rue.csv"

#  Convert the tuples into JSON and merge them with convert.json

node "./build-extended-conversion.js" "./temp/csventrifuge_enhance_name.csv" "./temp/csventrifuge_enhance_id.csv" "convert.json" "./temp/convert-merged.json"

# Finally, convert fields to OpenStreetMap tags

node "../../script/convert-tags.js" -c "./temp/convert-merged.json" "./temp/trpvc.geojson" "trpvcTagged.geojson"

# Generate vector tiles

tippecanoe --force --no-feature-limit --no-tile-size-limit \
  --buffer=0 \
  --maximum-zoom=14 --minimum-zoom=14 \
  --layer="roads" \
  --output="./temp/trpvcTagged.mbtiles" "./temp/trpvcTagged.geojson"

# Generate MapRoulette NotAnIssue buffers vector tiles

wget -O "./temp/maproulette.geojson" "https://maproulette.org/api/v2/challenge/view/$MAPROULETTE_CHALLENGE?status=2"

node "../../script/buffer.js" --radius=20 "./temp/maproulette.geojson" "maproulette-buffers.geojson"

# Merge MapRoulette buffers to OpenStreetMap buffers

tippecanoe --force --no-feature-limit --no-tile-size-limit \
  --maximum-zoom=14 --minimum-zoom=14 \
  --layer="buffers" \
  --output="./temp/luxembourg-buffers.mbtiles" \
  "./luxembourg-lines-buffers.geojson" "./luxembourg-polygons-buffers.geojson" "./temp/maproulette-buffers.geojson"

# Difference

if [ -d "./difference" ]; then rm -r "./difference/"; fi

mkdir -p "./difference"

node "../../script/difference.js" --output-dir="./difference" "./temp/trpvcTagged.mbtiles" "./temp/luxembourg-buffers.mbtiles"

# Our dataset doesn't have unique identifiers for segments of the same road, so we create one based on the geometry
node "./create-uid.js" "./difference/diff.geojson" "./difference/diff.geojson"