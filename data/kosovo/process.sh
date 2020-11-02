#!/bin/sh

# MAPROULETTE_CHALLENGE=14646

# Make script directory working directory

cd `dirname "$(realpath $0)"`

# Download & unzip data

mkdir -p "./source/"

# Convert to GeoJSON

if [ -d "./temp" ]; then rm -r "./temp/"; fi

mkdir -p "./temp/"

for file in ./source/RoadSegmentView_*.gpkg ; do
  if [ -f $file ]; then
    fname=$(basename "$file" ".gpkg")

    ogr2ogr -f "GeoJSON" -progress \
      -dim "XY" \
      -lco COORDINATE_PRECISION=6 \
      "./temp/$fname.geojson" \
      "$file"
  fi
done

for file in ./temp/RoadSegmentView_*.geojson ; do
  if [ -f $file ]; then
    ogr2ogr -progress -append "./temp/RoadSegmentView.geojson" "$file"
  fi
done

# Convert fields to OpenStreetMap tags

node "../../script/convert-tags.js" -c "./convert.json" "./temp/RoadSegmentView.geojson" "RoadSegmentViewTagged.geojson"

# Generate vector tiles

tippecanoe --force --no-feature-limit --no-tile-size-limit \
  --buffer=0 \
  --maximum-zoom=14 --minimum-zoom=14 \
  --layer="roads" \
  --output="./temp/RoadSegmentViewTagged.mbtiles" \
  "./temp/RoadSegmentViewTagged.geojson"

# Difference

if [ -d "./difference" ]; then rm -r "./difference"; fi

mkdir -p "./difference"

node "../../script/difference.js" --output-dir="./difference" "./temp/RoadSegmentViewTagged.mbtiles" "kosovo-buffers.mbtiles"
