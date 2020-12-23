#!/bin/sh

# Make script directory working directory

cd `dirname "$(realpath $0)"`

# Download Kosovo extract

if [ -f "kosovo-latest.osm.pbf" ]; then rm "kosovo-latest.osm.pbf"; fi

wget https://download.geofabrik.de/europe/kosovo-latest.osm.pbf

# Convert to GeoJSON

if [ -f "./kosovo-lines.geojson" ]; then rm "./kosovo-lines.geojson"; fi
if [ -f "./kosovo-polygons.geojson" ]; then rm "./kosovo-polygons.geojson"; fi

ogr2ogr -f "GeoJSON" -progress \
  -sql "SELECT name, highway FROM lines WHERE highway IS NOT NULL" \
  "./kosovo-lines.geojson" \
  "./kosovo-latest.osm.pbf"
ogr2ogr -f "GeoJSON" -progress \
  -sql "SELECT name, hstore_get_value(other_tags, 'highway') AS highway FROM multipolygons WHERE hstore_get_value(other_tags, 'highway') is not null" \
  "./kosovo-polygons.geojson" \
  "./kosovo-latest.osm.pbf"

# Generate buffer

node "../../script/buffer.js" --radius=20 "./kosovo-lines.geojson" "kosovo-lines-buffers.geojson"
node "../../script/buffer.js" --radius=5 "./kosovo-polygons.geojson" "kosovo-polygons-buffers.geojson"

# Generate vector tiles

tippecanoe --force --no-feature-limit --no-tile-size-limit \
  --maximum-zoom=14 --minimum-zoom=14 \
  --layer="buffers" \
  --output="./kosovo-buffers.mbtiles" \
  "./kosovo-lines-buffers.geojson" "./kosovo-polygons-buffers.geojson"
