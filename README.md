# Road Completion project

## History of the project

- [Open Summer of Code 2018](https://2018.summerofcode.be/roadcompletion.html)
- [OpenStreetMap Foundation microgrant (2020)](https://wiki.openstreetmap.org/wiki/Microgrants/Microgrants_2020/Proposal/Road_Completion_project)

## Process

1. Download OpenStreetMap data
1. Convert OpenStreetMap data to GeoJSON (keeping only `highway=*`)
1. Generate buffer around OpenStreetMap data
1. Download source data
1. Convert source data to GeoJSON (with optional filtering)
1. Convert source data to OpenStreetMap tags
1. Generate vector tiles from source data
1. Download false positive from [MapRoulette](https://maproulette.org/) challenge (*optional*)
1. Generate buffers around MapRoulette data (*optional*)
1. Generate vector tiles from OpenStreetMap (+ MapRoulette) buffers
1. Process difference : all the roads from the source data that are not in the OpenStreetMap (+ MapRoulette) buffers
1. Update MapRoulette challenge with latest data (*optional*)

## Requirements

- [GDAL 2.1+](https://gdal.org/)
- [tippecanoe](https://github.com/mapbox/tippecanoe)
- (Python, might be needed during [TileReduce](https://github.com/mapbox/tile-reduce) install)
