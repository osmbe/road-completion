# Road Completion project

*Software set-up inspired by ["Quality analysis for OpenStreetMap"](https://blog.mapbox.com/quality-analysis-for-openstreetmap-a9058eb79c9a) by [Matt Greene](https://github.com/MateoV) from [Mapbox](https://www.mapbox.com/)*

## Goals

OpenStreetMap (OSM) is extremly good at quickly creating a usable map. It is less good at getting to 100% finished on a specific topic. The last 2% of roads might take forever to get mapped in OpenStreetMap. This project aims to find these 2% with the help of external road data. This can be governement data or machine learned data. We then offer the missing roads as microtasks to the mapping community. This means that after we have "finished" the work, the OpenStreetMap data will be at least as complete as the reference dataset - so any trust placed in that reference can now be place in OpenStreetMap as well!

## History of the project

- [Diary post](https://www.openstreetmap.org/user/joost%20schouppe/diary/39250) and POC by [Joost Schouppe](https://github.com/joostschouppe) (8/2016)
- [Birds of a feather session at State of the Map 2016](https://wiki.openstreetmap.org/wiki/State_Of_The_Map_2016/Informal_Sessions#Mapping_with_open_geodata)
- [Project page in OpenStreetMap wiki](https://wiki.openstreetmap.org/wiki/WikiProject_Belgium/Road_completion_project)
- [Talk at FOSS4G Belgium 2017](https://slides.com/benabelshausen-1/deck-1) by [Ben Abelshausen](https://github.com/xivk)
- [Talk at State of the Map 2018](https://2018.stateofthemap.org/2018/T097-Road_Completion_in_Belgium_-_Mapping___verifying__all__the_roads_/) by [Ben Abelshausen](https://github.com/xivk)
- [Open Summer of Code 2018](https://2018.summerofcode.be/roadcompletion.html)
- [OpenStreetMap Foundation microgrant 2020](https://wiki.openstreetmap.org/wiki/Microgrants/Microgrants_2020/Proposal/Road_Completion_project)
- [OpenStreetMap Foundation microgrant 2020 - Final report](https://wiki.openstreetmap.org/wiki/Microgrants/Microgrants_2020/Proposal/Road_Completion_project/Report)

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

📉 [Statistics about datasets process](https://osmbe.github.io/road-completion/)

| Country                           | Region                                   | Source                    | MapRoulette           |
|-----------------------------------|------------------------------------------|---------------------------|-----------------------|
| :belgium: Belgium                 | [Bruxelles/Brussel (Brussels)][be-bru-1] | [UrbIS-Adm][be-bru-2]     | [Challenge][be-bru-3] |
| :belgium: Belgium                 | [Vlaanderen (Flanders)][be-vla-1]        | [Wegenregister][be-vla-2] | [Challenge][be-vla-3] |
| :belgium: Belgium                 | [Wallonie (Wallonia)][be-wal-1]          | [PICC][be-wal-2]          | [Challenge][be-wal-3] |
| :kosovo: [Kosovo][xk-1]           |                                          | [AKK][xk-2]               |                       |
| :luxembourg: [Luxembourg][lu-1]   |                                          | [TRP-VC][lu-2]            | [Challenge][lu-3]     |
| :netherlands: [Netherlands][nl-1] |                                          | [NWB][nl-2]               | [Challenge][nl-3]     |

[be-bru-1]: https://github.com/osmbe/road-completion/tree/master/data/belgium/brussels
[be-bru-2]: https://bric.brussels/en/our-solutions/urbis-solutions/urbis-data/urbis-adm
[be-bru-3]: https://maproulette.org/browse/challenges/14675
[be-vla-1]: https://github.com/osmbe/road-completion/tree/master/data/belgium/flanders
[be-vla-2]: https://download.vlaanderen.be/Producten/Detail?id=7698&title=Wegenregister_16_12_2021
[be-vla-3]: https://maproulette.org/browse/challenges/24090
[be-wal-1]: https://github.com/osmbe/road-completion/tree/master/data/belgium/wallonia
[be-wal-2]: http://geoportail.wallonie.be/catalogue/b795de68-726c-4bdf-a62a-a42686aa5b6f.html
[be-wal-3]: https://maproulette.org/browse/challenges/14681
[xk-1]: https://github.com/osmbe/road-completion/tree/master/data/kosovo
[xk-2]: https://ak.rks-gov.net/en/
[lu-1]: https://github.com/osmbe/road-completion/tree/master/data/luxembourg
[lu-2]: https://data.public.lu/en/datasets/transport-et-voies-de-communication/
[lu-3]: https://maproulette.org/browse/challenges/17749
[nl-1]: https://github.com/osmbe/road-completion/tree/master/data/netherlands
[nl-2]: https://nationaalwegenbestand.nl/
[nl-3]: https://maproulette.org/browse/challenges/17332

## Replicate

If you want to run the comparison process in your country/region, you simply have to replicate one of the existing regions (for instance, [Flanders](https://github.com/osmbe/road-completion/tree/master/data/belgium/flanders)) :

- `process.sh` is the comparison shell script (see [example](https://github.com/osmbe/road-completion/blob/master/data/belgium/flanders/process.sh))
- `filter.sql` is the SQL query to filter your data (see [example](https://github.com/osmbe/road-completion/blob/master/data/belgium/flanders/filter.sql) and [usage](https://github.com/osmbe/road-completion/blob/master/data/belgium/flanders/process.sh#L25-L31))
- `convert.json` is the tag conversion (from your data to OSM tag(s)) (see [documentation](https://github.com/osmbe/road-completion/blob/master/script/README.md#convert-source-field-to-openstreetmap-tag) and [example](https://github.com/osmbe/road-completion/blob/master/data/belgium/flanders/convert.json))

You can find more documentation about the scripts here : <https://github.com/osmbe/road-completion/blob/master/script/README.md>

## Scope

This set-up is ideal if there are relatively few missing roads. If there are whole swats of network missing in OSM, you might consider a tool like [Cygnus](https://www.openstreetmap.org/user/mvexel/diary/36746) instead.

The current matching is based on a simple buffer - so both OSM and the ref dataset need to be af high geometric quality to result in a reasonable amount of tasks. However, you are invited to create more advanced comparison processes. Next on our roadmap is adding attribute comparisons, for example to compare street names.
