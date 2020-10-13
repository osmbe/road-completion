#!/bin/sh

# Make script directory working directory

cd `dirname "$(realpath $0)"`

# Download Belgium extract

if [ ! -f "belgium-latest.osm.pbf" ]; then
  wget https://download.geofabrik.de/europe/belgium-latest.osm.pbf
fi

# Convert to GeoJSON

if [ -f "./belgium.geojson" ]; then rm "./belgium.geojson"; fi

ogr2ogr -f "GeoJSON" -progress \
  -select "name,highway" \
  -where "highway is not null" \
  "./belgium.geojson" \
  "./belgium-latest.osm.pbf" "lines"

# Generate buffer

node "../../script/buffer.js" "./belgium.geojson" "belgium-buffer.geojson"

# Generate vector tiles

# tippecanoe --force --output="./belgium.mbtiles" "./belgium.geojson" --layer="roads" --no-feature-limit --no-tile-size-limit
tippecanoe --force --output="./belgium-buffers.mbtiles" "./belgium-buffers.geojson" --layer="buffers" --no-feature-limit --no-tile-size-limit
