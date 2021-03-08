# Road Completion - 🇳🇱 Netherlands

Sources: <https://nationaalwegenbestand.nl/aanbieders>
Direct Link: <https://www.rijkswaterstaat.nl/apps/geoservices/geodata/dmc/nwb-wegen/>

## Filters

### `BST_CODE` (*Baansubsoort*)

```sql
"BST_CODE" NOT IN ('VD', 'VV')
```

Filtering out features that are not considered roads in OSM, see Tags for more.

*Classificering van de functie die een wegvak in het wegennetwerk heeft.*

| Value | Description (original)                                    | Description (Translated)                               |
|-------|-----------------------------------------------------------|--------------------------------------------------------|
| VV    | Vliegverkeer                                              | Air Traffic (runway or taxiway)                        |
| VD    | Veerdienst                                                | Ferry                                                  |

## Tags

### `BST_CODE` (*Baansubsoort*)
| Value | Description (original)                                    | Description (Translated)                               | OSM Tags (if empty `highway=unclassified`)
|-------|-----------------------------------------------------------|--------------------------------------------------------|-------------------------------------------
| VWG   | Ventweg                                                   | Parallel road in city                                  | 
| PAR   | Parallelweg - niet ventweg                                | Parallel road                                          |
| MRB   | Minirotondebaan                                           | Road on mini-roundabout                                |  
| NRB   | Normale rotondebaan - niet minirotondebaan                | Road on roundabout                                     | `highway=unclassified`, `junction=roundabout` and `oneway=yes`
| OPR   | Toerit - synomien: Oprit                                  | On ramp to road (OSM `_link`)                          |
| AFR   | Afrit                                                     | Off ramp from road (OSM `_link`)                       |
| PST   | Puntstuk = snijpunt verharding                            | Intersection                                           |
| VBD   | Verbindingsweg direct                                     | Direct link road                                       |
| VBI   | Verbindingsweg indirect                                   | Indirect link road                                     |
| VBS   | Verbindingsweg semi-direct                                | Semi-direct link road                                  |
| VBR   | Verbindingsweg rangeerbaan                                | Collector/Distributor Lane                             |
| VBK   | Verbindingsweg kortsluitend                               | Link road connecting from at least one other link road |
| VBW   | Verbindingsweg - overig                                   | Miscellaneous link road                                |
| DST   | Doorsteek                                                 | Bypass between roads                                   |
| PKP   | Verzorgingsbaan van/naar parkeerplaats                    | Slip road to/from parking lot                          | `highway=service`
| PKB   | Verzorgingsbaan van/naar parkeerplaats bij benzinestation | Slip road to/from parking lot to petrol station        | `highway=service`
| BST   | Verzorgingsbaan van/naar benzinestation                   | Slip road to/from petrol station                       | `highway=service`
| YYY   | Overig                                                    | Miscellaneous                                          |
| BU    | Busbaan                                                   | Bus road                                               | `highway=service`, `access=no`, `psv=yes` and `fixme=Access for taxis`
| FP    | Fietspad                                                  | Cycleway                                               | `highway=cycleway`
| HR    | Hoofdrijbaan                                              | Road                                                   |
| TN    | Tussenbaan                                                | Road connecting slip roads                             |
| VP    | Voetpad                                                   | Footway                                                | `highway=footway`
| OVB   | OV-baan                                                   | Public transport road (tramway, bus road, etc)         | `highway=service`, `access=no` and `psv=yes`
| CADO  | Calamiteiten doorgang                                     | Emergency bypass                                       | `highway=service`, `access=no`, `emergency=yes` and `service=emergency_access`
| TRB   | Turborotondebaan                                          | Road on turbo-roundabout                               | `highway=unclassified`, `junction=roundabout` and `oneway=yes`
| RP    | Ruiterpad                                                 | Bridleway                                              | `highway=bridleway`
| VV    | Vliegverkeer                                              | Air Traffic (runway or taxiway)                        | not used
| PP    | Parkeerplaats                                             | Road on parking lot                                    | `highway=service` and `service=parking_aisle`
| PC    | Parkeerplaats tbv carpool                                 | Road on parking lot for carpool                        | `highway=service` and `service=parking_aisle`
| PR    | Parkeerplaats P+R                                         | Road on parking lot for P+R                            | `highway=service` and `service=parking_aisle`
| VD    | Veerdienst                                                | Ferry                                                  | not used