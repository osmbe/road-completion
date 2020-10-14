"use strict";

import tileReduce from "@mapbox/tile-reduce";
import fs from "fs";
import { FeatureCollection } from "@turf/helpers";
import path from "path";

import fileExists from "./file-exists";

const args = process.argv.slice(2);

console.log(`Roads: ${path.resolve(args[0])}`);
console.log(`OSM Buffers: ${path.resolve(args[1])}`);

if (fileExists(args[0], args[1]) !== true) process.exit(1);

const directory = path.dirname(args[0]);

const options = {
  sourceCover: "road",
  log: true,
  map: path.join(__dirname, "difference/buffer.js"),
  sources: [
    {
      name: "buffer",
      mbtiles: fs.realpathSync(args[1]),
      layers: ["buffers"],
    },
    {
      name: "road",
      mbtiles: fs.realpathSync(args[0]),
      layers: ["roads"],
    },
  ],
};

let collectionNotWithin: FeatureCollection = {
  type: "FeatureCollection",
  features: [],
};
let stats: any[] = [];

tileReduce(options)
  .on("reduce", (result: any) => {
    stats.push(result.stats);

    collectionNotWithin.features = collectionNotWithin.features.concat(
      result.featuresNotWithin
    );
  })
  .on("end", function () {
    fs.writeFileSync(`${directory}/stats.json`, JSON.stringify(stats));

    const stream = fs.createWriteStream(`${directory}/notWithin.geojson`);

    stream.write('{"type":"FeatureCollection","features":[\n');

    collectionNotWithin.features.forEach((feature, index: number) => {
      stream.write(JSON.stringify(feature));

      if (index < collectionNotWithin.features.length - 1) {
        stream.write(",\n");
      }
    });

    stream.write("\n]}");
    stream.end();

    console.log("Features count: %d", collectionNotWithin.features.length);
  });
