# Road Completion project

*Inspired by ["Quality analysis for OpenStreetMap"](https://blog.mapbox.com/quality-analysis-for-openstreetmap-a9058eb79c9a) by [Matt Greene](https://github.com/MateoV) from [Mapbox](https://www.mapbox.com/)*

## History of the project

- [Presentation at FOSS4G Belgium 2017](https://slides.com/benabelshausen-1/deck-1) by [Ben Abelshausen](https://github.com/xivk)
- [Presentation at State of the Map 2018](https://2018.stateofthemap.org/2018/T097-Road_Completion_in_Belgium_-_Mapping___verifying__all__the_roads_/) by [Ben Abelshausen](https://github.com/xivk)
- [Open Summer of Code 2018](https://2018.summerofcode.be/roadcompletion.html)
- [OpenStreetMap Foundation microgrant 2020](https://wiki.openstreetmap.org/wiki/Microgrants/Microgrants_2020/Proposal/Road_Completion_project)

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

## Data

| Country           | Region                                   | Source                    | MapRoulette |
|-------------------|------------------------------------------|---------------------------|-------------|
| :belgium: Belgium | [Bruxelles/Brussel (Brussels)][be-bru-1] | [UrbIS-Adm][be-bru-2]     |             |
| :belgium: Belgium | [Vlaanderen (Flanders)][be-vla-1]        | [Wegenregister][be-vla-2] |             |
| :belgium: Belgium | [Wallonie (Wallonia)][be-wal-1]          | [PICC][be-wal-2]          |             |

[be-bru-1]: https://github.com/osmbe/road-completion/tree/master/data/belgium/brussels
[be-bru-2]: https://bric.brussels/en/our-solutions/urbis-solutions/urbis-data/urbis-adm
[be-vla-1]: https://github.com/osmbe/road-completion/tree/master/data/belgium/flanders
[be-vla-2]: https://download.vlaanderen.be/Producten/Detail?id=6367&title=Wegenregister_17_09_2020
[be-wal-1]: https://github.com/osmbe/road-completion/tree/master/data/belgium/wallonia
[be-wal-2]: http://geoportail.wallonie.be/catalogue/b795de68-726c-4bdf-a62a-a42686aa5b6f.html
