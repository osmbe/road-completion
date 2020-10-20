#!/bin/sh

# Make script directory working directory

cd `dirname "$(realpath $0)"`

# Download Luxembourg extract

if [ -f "luxembourg-latest.osm.pbf" ]; then rm "luxembourg-latest.osm.pbf"; fi

wget https://download.geofabrik.de/europe/luxembourg-latest.osm.pbf

# Convert to GeoJSON

if [ -f "./luxembourg-lines.geojson" ]; then rm "./luxembourg-lines.geojson"; fi
if [ -f "./luxembourg-polygons.geojson" ]; then rm "./luxembourg-polygons.geojson"; fi

ogr2ogr -f "GeoJSON" -progress \
  -sql "SELECT name, highway FROM lines WHERE highway IS NOT NULL" \
  "./luxembourg-lines.geojson" \
  "./luxembourg-latest.osm.pbf"
ogr2ogr -f "GeoJSON" -progress \
  -sql "SELECT name, hstore_get_value(other_tags, 'highway') AS highway, place FROM multipolygons WHERE (hstore_get_value(other_tags, 'highway') is not null) OR (place = 'square')" \
  "./luxembourg-polygons.geojson" \
  "./luxembourg-latest.osm.pbf"

# Generate buffer

node "../../script/buffer.js" --radius=20 "./luxembourg-lines.geojson" "luxembourg-lines-buffers.geojson"
node "../../script/buffer.js" --radius=5 "./luxembourg-polygons.geojson" "luxembourg-polygons-buffers.geojson"

# Generate vector tiles

tippecanoe --force --no-feature-limit --no-tile-size-limit \
  --maximum-zoom=14 --minimum-zoom=14 \
  --layer="buffers" \
  --output="./luxembourg-buffers.mbtiles" "./luxembourg-lines-buffers.geojson" "./luxembourg-polygons-buffers.geojson"
