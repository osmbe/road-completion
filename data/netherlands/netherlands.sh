#!/bin/sh

# Make script directory working directory

cd `dirname "$(realpath $0)"`

# Download Netherlands extract extract

if [ -f "netherlands-latest.osm.pbf" ]; then rm "netherlands-latest.osm.pbf"; fi

wget https://download.geofabrik.de/europe/netherlands-latest.osm.pbf

# Convert to GeoJSON

if [ -f "./netherlands-lines.geojson" ]; then rm "./netherlands-lines.geojson"; fi
if [ -f "./netherlands-polygons.geojson" ]; then rm "./netherlands-polygons.geojson"; fi

ogr2ogr -f "GeoJSON" -progress \
  -sql "SELECT name, highway FROM lines WHERE highway IS NOT NULL" \
  "./netherlands-lines.geojson" \
  "./netherlands-latest.osm.pbf"
ogr2ogr -f "GeoJSON" -progress \
  -sql "SELECT name, hstore_get_value(other_tags, 'highway') AS highway, place FROM multipolygons WHERE (hstore_get_value(other_tags, 'highway') is not null) OR (place = 'square')" \
  "./netherlands-polygons.geojson" \
  "./netherlands-latest.osm.pbf"

# Generate buffer

node "../../script/buffer.js" --radius=20 "./netherlands-lines.geojson" "netherlands-lines-buffers.geojson"
node "../../script/buffer.js" --radius=5 "./netherlands-polygons.geojson" "netherlands-polygons-buffers.geojson"

# Generate vector tiles

tippecanoe --force --no-feature-limit --no-tile-size-limit \
  --maximum-zoom=14 --minimum-zoom=14 \
  --layer="buffers" \
  --output="./netherlands-buffers.mbtiles" \
  "./netherlands-lines-buffers.geojson" "./netherlands-polygons-buffers.geojson"
