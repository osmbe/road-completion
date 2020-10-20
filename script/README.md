# Road Completion - Scripts

Scripts are built from TypeScript using `npm run build`.

## Generate buffers

Scrip: `buffer.js`  
Source: [`src/buffer.ts`](./src/buffer.ts)

### Description

The `buffer.js` script will generate a buffer (specified in meters) around each feature in a specified GeoJSON file. The result will be generated in the same folder as the specified GeoJSON file.

### Usage

```shell
node "buffers.js" -r 10 "path/to/myfile.geojson" "buffers.geojson"
```

OR

```shell
node "buffers.js" --radius=10 "path/to/myfile.geojson" "buffers.geojson"
```

## Convert source field to OpenStreetMap tag

Scrip: `convert-tags.js`  
Source: [`src/convert-tags.ts`](./src/convert-tags.ts)

### Description

The `convert-tags.js` script will convert source data field (from a specified GeoJSON file) to OpenStreetMap tag(s) based on a configuration file. The result will be generated in the same folder as the specified GeoJSON file.

### Usage

```shell
node "convert-tags.js" -c "path/to/convert.json" "path/to/mysource.geojson" "tagged.geojson"
```

### Configuration file: `convert.json`

```json
{
  "MYSOURCEFIELD": {
    "VALUE1": {
      "OSMTAG1": "OSMTAG1_VALUE",
      "OSMTAG2": "OSMTAG2_VALUE",
      ...
    },
    "VALUES2": {
      ...
    },
    ...
  },
  ...
}
```

You can use `*` as value (see `VALUE1` or `VALUE2` in the example above) to specify all values.

See [Brussels, Belgium configuration file](../data/belgium/brussels/convert.json) or [Flanders, Belgium configuration file](../data/belgium/flanders/convert.json) for reference.

## Calculate difference (tile by tile) between source and OpenStreetMap

Scrip: `difference.js`  
Source: [`src/difference.ts`](./src/difference.ts)

### Description

Using [TileReduce](https://github.com/mapbox/tile-reduce), the process does tile by tile:

1. Normalize all roads and buffers in current tile
1. Flatten all roads and buffers in current tile
1. Merge all the OpenStreetMap (+ Map Roulette) with() in current tile
1. Get all roads that are not entirely within the merged buffer in current tile

### Usage

```shell
node "difference.js" --output-dir="path/to/directory" "path/to/mysource.mbtiles" "path/to/mybuffers.mbtiles"
```

### Result files

#### `stats.json`

Contains statistics about the difference process:

- Coordinates of the tile (`[x, y, zoom_level]`)
- Number of roads in the tile
- Number of buffers in the tile
- Number of roads that are not entirely within the merged buffer in the tile

#### `diff.geojson`

Contains all the roads that are not entirely within the buffers.
