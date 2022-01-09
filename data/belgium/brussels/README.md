# Road Completion - 🇧🇪 Belgium - Brussels

[![🇧🇪 Brussels, Belgium](https://github.com/osmbe/road-completion/actions/workflows/belgium-brussels.yml/badge.svg)](https://github.com/osmbe/road-completion/actions/workflows/belgium-brussels.yml)

> Source: <https://bric.brussels/en/our-solutions/urbis-solutions/urbis-data/urbis-adm>

## Filters

### `TYPE`

```sql
"TYPE" NOT IN ('M', 'O', 'MS', 'RS', 'RT', 'MT')
```

See below for values decription.

## Tags

### `TYPE`

| Value | Description                  | Note                                              | OSM Tag(s)                                  |
|-------|------------------------------|---------------------------------------------------|---------------------------------------------|
| S     | Section                      | Tronçon de rue                                    | `highway=unclassified`                      |
| I     | Intersection                 | Carrefour                                         | `highway=unclassified`                      |
| T     | Road Tunnel                  | Tunnel routier                                    | `highway=unclassified` + `tunnel=yes`       |
| PT    | Section                      | Pedestrian Tunnel                                 | `highway=footway` + `tunnel=yes`            |
| B     | Bridge                       | Pont/Viaduc routier                               | `highway=unclassified` + `bridge=yes`       |
| PB    | Pedestrian Bridge            | Pont piéton                                       | `highway=footway` + `bridge=yes`            |
| A     | Access ramp                  | Rampe d'accès                                     | `highway=unclassified`                      |
| P     | Place                        | Place                                             | `highway=unclassified` + `place=square`     |
| G     | Galery                       | Galerie                                           | `highway=pedestrian` + `covered=yes`        |
| W     | Way                          | Chemin / ruelle / venelle                         | `highway=unclassified`                      |
| M     | Median                       | Terre-plein / berme / rond-point                  |                                             |
| C     | Own site public transport    | Site propre aménagé pour les transports en commun | `highway=unclassified` + `psv=designated`   |
| AC    | Access Ramp public transport | Rampe d’accès pour les trams / bus                | `highway=unclassified` + `psv=designated`   |
| IC    | Intersection Common          | Carrefour partagé avec des voies de trams         | `highway=unclassified`                      |
| K     | Parking                      | Zone de parking en voirie en îlot                 | `highway=service` + `service=parking_aisle` |
| SC    | Section Common               | Tronçon partagé avec des voies de tram            | `highway=unclassified`                      |
| IL    | Intersection Level Crossing  | Carrefour / passage à niveau                      | `highway=unclassified`                      |
| O     | Off-road                     | Terrain vague, en friche                          |                                             |
| MS    | Metro Station                | Station de métro                                  |                                             |
| RS    | Rail Station                 | Gare de chemin de fer                             |                                             |
| RT    | Rail Tunnel                  | Tunnel SNCB                                       |                                             |
| MT    | Metro Tunnel                 | Tunnel de métro                                   |                                             |
