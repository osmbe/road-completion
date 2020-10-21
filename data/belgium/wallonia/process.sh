#!/bin/sh

# MAPROULETTE_CHALLENGE=14646

# Make script directory working directory

cd `dirname "$(realpath $0)"`

# Download & unzip data

mkdir -p "./source/"

FILENAME="PICC_vDIFF_SHAPE_31370_PROV_BRABANT_WALLON"
if [ ! -d "./source/$FILENAME" ]; then
  wget -O "./source/$FILENAME.zip" "https://geoservices.wallonie.be/geotraitement/spwdatadownload/results/b795de68-726c-4bdf-a62a-a42686aa5b6f/$FILENAME.zip"
  unzip "./source/$FILENAME.zip" -d "./source/$FILENAME/" "VOIRIE_AXE.*"
fi
FILENAME="PICC_vDIFF_SHAPE_31370_PROV_HAINAUT"
if [ ! -d "./source/$FILENAME" ]; then
  wget -O "./source/$FILENAME.zip" "https://geoservices.wallonie.be/geotraitement/spwdatadownload/results/b795de68-726c-4bdf-a62a-a42686aa5b6f/$FILENAME.zip"
  unzip "./source/$FILENAME.zip" -d "./source/$FILENAME/" "VOIRIE_AXE.*"
fi
FILENAME="PICC_vDIFF_SHAPE_31370_PROV_LIEGE"
if [ ! -d "./source/$FILENAME" ]; then
  wget -O "./source/$FILENAME.zip" "https://geoservices.wallonie.be/geotraitement/spwdatadownload/results/b795de68-726c-4bdf-a62a-a42686aa5b6f/$FILENAME.zip"
  unzip "./source/$FILENAME.zip" -d "./source/$FILENAME/" "VOIRIE_AXE.*"
fi
FILENAME="PICC_vDIFF_SHAPE_31370_PROV_NAMUR"
if [ ! -d "./source/$FILENAME" ]; then
  wget -O "./source/$FILENAME.zip" "https://geoservices.wallonie.be/geotraitement/spwdatadownload/results/b795de68-726c-4bdf-a62a-a42686aa5b6f/$FILENAME.zip"
  unzip "./source/$FILENAME.zip" -d "./source/$FILENAME/" "VOIRIE_AXE.*"
fi
FILENAME="PICC_vDIFF_SHAPE_31370_PROV_LUXEMBOURG"
if [ ! -d "./source/$FILENAME" ]; then
  wget -O "./source/$FILENAME.zip" "https://geoservices.wallonie.be/geotraitement/spwdatadownload/results/b795de68-726c-4bdf-a62a-a42686aa5b6f/$FILENAME.zip"
  unzip "./source/$FILENAME.zip" -d "./source/$FILENAME/" "VOIRIE_AXE.*"
fi

# Convert to GeoJSON

# if [ -d "./temp" ]; then rm -r "./temp/"; fi

# mkdir -p "./temp/"

# ogr2ogr -f "GeoJSON" -progress \
#   -s_srs "EPSG:31370" -t_srs "EPSG:4326" -dim "XY" \
#   -makevalid \
#   -sql "@filter.sql" \
#   -lco COORDINATE_PRECISION=6 \
#   "./temp/BRA_VOIRIE_AXE.geojson" \
#   "./source/PICC_vDIFF_SHAPE_31370_PROV_BRABANT_WALLON/VOIRIE_AXE.shp"
# ogr2ogr -f "GeoJSON" -progress \
#   -s_srs "EPSG:31370" -t_srs "EPSG:4326" -dim "XY" \
#   -makevalid \
#   -sql "@filter.sql" \
#   -lco COORDINATE_PRECISION=6 \
#   "./temp/HAI_VOIRIE_AXE.geojson" \
#   "./source/PICC_vDIFF_SHAPE_31370_PROV_HAINAUT/VOIRIE_AXE.shp"
# ogr2ogr -f "GeoJSON" -progress \
#   -s_srs "EPSG:31370" -t_srs "EPSG:4326" -dim "XY" \
#   -makevalid \
#   -sql "@filter.sql" \
#   -lco COORDINATE_PRECISION=6 \
#   "./temp/LIE_VOIRIE_AXE.geojson" \
#   "./source/PICC_vDIFF_SHAPE_31370_PROV_LIEGE/VOIRIE_AXE.shp"
# ogr2ogr -f "GeoJSON" -progress \
#   -s_srs "EPSG:31370" -t_srs "EPSG:4326" -dim "XY" \
#   -makevalid \
#   -sql "@filter.sql" \
#   -lco COORDINATE_PRECISION=6 \
#   "./temp/NAM_VOIRIE_AXE.geojson" \
#   "./source/PICC_vDIFF_SHAPE_31370_PROV_NAMUR/VOIRIE_AXE.shp"
# ogr2ogr -f "GeoJSON" -progress \
#   -s_srs "EPSG:31370" -t_srs "EPSG:4326" -dim "XY" \
#   -makevalid \
#   -sql "@filter.sql" \
#   -lco COORDINATE_PRECISION=6 \
#   "./temp/LUX_VOIRIE_AXE.geojson" \
#   "./source/PICC_vDIFF_SHAPE_31370_PROV_LUXEMBOURG/VOIRIE_AXE.shp"

# Convert fields to OpenStreetMap tags

# node "../../../script/convert-tags.js" -c "./convert.json" "./temp/BRA_VOIRIE_AXE.geojson" "BRA_VOIRIE_AXETagged.geojson"
# node "../../../script/convert-tags.js" -c "./convert.json" "./temp/HAI_VOIRIE_AXE.geojson" "HAI_VOIRIE_AXETagged.geojson"
# node "../../../script/convert-tags.js" -c "./convert.json" "./temp/LIE_VOIRIE_AXE.geojson" "LIE_VOIRIE_AXETagged.geojson"
# node "../../../script/convert-tags.js" -c "./convert.json" "./temp/NAM_VOIRIE_AXE.geojson" "NAM_VOIRIE_AXETagged.geojson"
# node "../../../script/convert-tags.js" -c "./convert.json" "./temp/LUX_VOIRIE_AXE.geojson" "LUX_VOIRIE_AXETagged.geojson"

# Generate vector tiles

# tippecanoe --force --no-feature-limit --no-tile-size-limit \
#   --buffer=0 \
#   --maximum-zoom=14 --minimum-zoom=14 \
#   --layer="roads" \
#   --output="./temp/BRA_VOIRIE_AXETagged.mbtiles" \
#   "./temp/BRA_VOIRIE_AXETagged.geojson"
# tippecanoe --force --no-feature-limit --no-tile-size-limit \
#   --buffer=0 \
#   --maximum-zoom=14 --minimum-zoom=14 \
#   --layer="roads" \
#   --output="./temp/HAI_VOIRIE_AXETagged.mbtiles" \
#   "./temp/HAI_VOIRIE_AXETagged.geojson"
# tippecanoe --force --no-feature-limit --no-tile-size-limit \
#   --buffer=0 \
#   --maximum-zoom=14 --minimum-zoom=14 \
#   --layer="roads" \
#   --output="./temp/LIE_VOIRIE_AXETagged.mbtiles" \
#   "./temp/LIE_VOIRIE_AXETagged.geojson"
# tippecanoe --force --no-feature-limit --no-tile-size-limit \
#   --buffer=0 \
#   --maximum-zoom=14 --minimum-zoom=14 \
#   --layer="roads" \
#   --output="./temp/NAM_VOIRIE_AXETagged.mbtiles" \
#   "./temp/NAM_VOIRIE_AXETagged.geojson"
# tippecanoe --force --no-feature-limit --no-tile-size-limit \
#   --buffer=0 \
#   --maximum-zoom=14 --minimum-zoom=14 \
#   --layer="roads" \
#   --output="./temp/LUX_VOIRIE_AXETagged.mbtiles" \
#   "./temp/LUX_VOIRIE_AXETagged.geojson"

# Difference

if [ -d "./difference/BRA" ]; then rm -r "./difference/BRA"; fi
if [ -d "./difference/HAI" ]; then rm -r "./difference/HAI"; fi
if [ -d "./difference/LIE" ]; then rm -r "./difference/LIE"; fi
if [ -d "./difference/NAM" ]; then rm -r "./difference/NAM"; fi
if [ -d "./difference/LUX" ]; then rm -r "./difference/LUX"; fi

mkdir -p "./difference/BRA"
mkdir -p "./difference/HAI"
mkdir -p "./difference/LIE"
mkdir -p "./difference/NAM"
mkdir -p "./difference/LUX"

node "../../../script/difference.js" --output-dir="./difference/BRA" "./temp/BRA_VOIRIE_AXETagged.mbtiles" "../belgium-buffers.mbtiles"
node "../../../script/difference.js" --output-dir="./difference/HAI" "./temp/HAI_VOIRIE_AXETagged.mbtiles" "../belgium-buffers.mbtiles"
node "../../../script/difference.js" --output-dir="./difference/LIE" "./temp/LIE_VOIRIE_AXETagged.mbtiles" "../belgium-buffers.mbtiles"
node "../../../script/difference.js" --output-dir="./difference/NAM" "./temp/NAM_VOIRIE_AXETagged.mbtiles" "../belgium-buffers.mbtiles"
node "../../../script/difference.js" --output-dir="./difference/LUX" "./temp/LUX_VOIRIE_AXETagged.mbtiles" "../belgium-buffers.mbtiles"

# Merge diff GeoJSON

if [ -f "./difference/diff.geojson" ]; then rm "./difference/diff.geojson"; fi

ogr2ogr -f "GeoJSON" -progress "./difference/diff.geojson" "./difference/BRA/diff.geojson"
ogr2ogr -f "GeoJSON" -progress -append "./difference/diff.geojson" "./difference/HAI/diff.geojson"
ogr2ogr -f "GeoJSON" -progress -append "./difference/diff.geojson" "./difference/LIE/diff.geojson"
ogr2ogr -f "GeoJSON" -progress -append "./difference/diff.geojson" "./difference/NAM/diff.geojson"
ogr2ogr -f "GeoJSON" -progress -append "./difference/diff.geojson" "./difference/LUX/diff.geojson"
