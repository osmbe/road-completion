# Road Completion - 🇱🇺 Luxembourg

Source: <https://data.public.lu/fr/datasets/transport-et-voies-de-communication/>

Complete description of all attributes: <https://data.public.lu/fr/datasets/r/d2d92fc6-1cfa-4c97-8e41-31e78f443099>

## Filters

```sql
"NOM_RUE" <> '' AND ("TRP_CLAS_L" <> 'Chemin de fer' OR ("TRP_CLAS_L" <> 'Non codé' AND "TRP_CLAS_L" <> 'autre'))
```

Filtering out features without a name, and features which aren't streets (train tracks, forest tracks, and unknown classification).

| Value | Description (original) | Description (translated) |
|-------|------------------------|--------------------------|
| NOM_RUE | Nom de la rue  | Street name |
| TRP_CLAS_L | Classification | Street Classification |

## Tags
The tagging scheme follows the [convention used in Luxembourg](https://wiki.openstreetmap.org/wiki/WikiProject_Luxembourg/Roads#Overview).

### `TRP_CLAS_L` (*TRP_CLASS_LOOKUP*)
| Value | Description | OSM Tags |
|-------|-------------|----------|
| Autoroute | Highway | `highway=motorway` |
| Nationale | National road | `highway=primary` |
| Chemin repris | State-managed road | `highway=secondary` |
| Chemin vicinal | Residential road | `highway=residential` |
| Chemin de fer | Train tracks | |
| Non codé | Tracks | |
| autre | Other | |

### `TRP_NIVE_L` (*TRP_NIVEAU_LOOKUP*)
| Value | Description | OSM Tags |
|-------|-------------|----------|
|passage supérieur 1|Bridge|`bridge=yes` and `layer=1`|
