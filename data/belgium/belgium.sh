#!/bin/sh

# Make script directory working directory

cd `dirname "$(realpath $0)"`

# Download Belgium extract

if [ ! -f "belgium-latest.osm.pbf" ]; then
  wget https://download.geofabrik.de/europe/belgium-latest.osm.pbf
fi

# Convert to GeoJSON

if [ -f "./belgium-lines.geojson" ]; then rm "./belgium-lines.geojson"; fi
if [ -f "./belgium-polygons.geojson" ]; then rm "./belgium-polygons.geojson"; fi

ogr2ogr -f "GeoJSON" -progress \
  -sql "SELECT name, highway FROM lines WHERE highway IS NOT NULL" \
  "./belgium-lines.geojson" \
  "./belgium-latest.osm.pbf"
ogr2ogr -f "GeoJSON" -progress \
  -sql "SELECT name, hstore_get_value(other_tags, 'highway') AS highway FROM multipolygons WHERE hstore_get_value(other_tags, 'highway') is not null" \
  "./belgium-polygons.geojson" \
  "./belgium-latest.osm.pbf"

# Generate buffer

node "../../script/buffer.js" --radius=20 "./belgium-lines.geojson" "belgium-lines-buffers.geojson"
node "../../script/buffer.js" --radius=5 "./belgium-polygons.geojson" "belgium-polygons-buffers.geojson"

# Generate vector tiles

tippecanoe --force --no-feature-limit --no-tile-size-limit \
  --maximum-zoom=14 --minimum-zoom=14 \
  --layer="buffers" \
  --output="./belgium-buffers.mbtiles" \
  "./belgium-lines-buffers.geojson" "./belgium-polygons-buffers.geojson"
