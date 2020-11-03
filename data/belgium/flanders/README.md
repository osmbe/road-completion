# Road Completion - 🇧🇪 Belgium - Flanders

Source: <https://download.vlaanderen.be/Producten/Detail?id=6367&title=Wegenregister_17_09_2020>

## Filters

### `LSTRNM` + `RSTRNM`

Filter out all the roads without a name.

### `STATUS` (*Status*)

```sql
"STATUS" = 4
```

*De status van het wegsegment*

| Value | Description               | Note                                                        |
|-------|---------------------------|-------------------------------------------------------------|
| 1     | *vergunning aangevraagd*  | *Weg komt voor op officieel document in behandeling*        |
| 2     | *bouwvergunning verleend* | *Weg komt voor op goedgekeurd, niet vervallen bouwdossier*  |
| 3     | *in aanbouw*              | *Aanvang der werken is gemeld.*                             |
| 4     | *in gebruik*              | *Werken zijn opgeleverd.*                                   |
| 5     | *buiten gebruik*          | *Fysieke weg is buiten gebruik gesteld maar niet gesloopt.* |
| -8    | *niet gekend*             | *Geen informatie beschikbaar*                               |

### `BEHEER` (*Beheer*)

```sql
"BEHEER" <> 4
```

*De organisatie die verantwoordelijk is voor het fysieke onderhoud en beheer van de weg op het terrein.*

| Value | Description   | Note                                      |
|-------|---------------|-------------------------------------------|
| -7    | *andere*      | Description is extracted from `LBLBEHEER` |
| -8    | *niet gekend* | Description is extracted from `LBLBEHEER` |
| ...   |               |                                           |

## Tags

### `MORF` (*Morfologische wegklasse*)

`highway=unclassified`

### `TGBEP` (*Toegangsbeperking*)

| Value | Description                | Note                                                                             | OSM Tag(s)       |
|-------|----------------------------|----------------------------------------------------------------------------------|------------------|
| 1     | *openbare weg*             | *Weg is publiek toegankelijk*                                                    | `access=yes`     |
| 2     | *onmogelijke toegang*      | *Weg is niet toegankelijk vanwege de aanwezigheid van hindernissen of obstakels* |                  |
| 3     | *verboden toegang*         | *Toegang tot de weg is bij wet verboden*                                         | `access=no`      |
| 4     | *privaatweg*               | *Toegang tot de weg is beperkt aangezien deze een private eigenaar heeft*        | `access=private` |
| 5     | *seizoensgebonden toegang* | *Weg is afhankelijk van het seizoen (on)toegankelijk*                            |                  |
| 6     | *tolweg*                   | *Toegang tot de weg is onderhevig aan tolheffingen*                              |                  |
