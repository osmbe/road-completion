"use strict";

import tileReduce from "@mapbox/tile-reduce";
import { FeatureCollection } from "@turf/helpers";
import fs from "fs";
import minimist from "minimist";
import path from "path";

import fileExists from "./file-exists";

const options = minimist(process.argv.slice(2));
const roads = options._[0];
const buffers = options._[1];

console.log(`Roads: ${path.resolve(roads)}`);
console.log(`OSM Buffers: ${path.resolve(buffers)}`);

if (fileExists(roads, buffers) !== true) process.exit(1);

const directory =
  typeof options["output-dir"] !== "undefined"
    ? path.resolve(options["output-dir"])
    : path.dirname(roads);

let collectionNotWithin: FeatureCollection = {
  type: "FeatureCollection",
  features: [],
};
let stats: any[] = [];

try {
  tileReduce({
    sourceCover: "road",
    log: true,
    map: path.resolve(__dirname, "difference/buffer.js"),
    sources: [
      {
        name: "buffer",
        mbtiles: buffers,
        layers: ["buffers"],
      },
      {
        name: "road",
        mbtiles: roads,
        layers: ["roads"],
      },
    ],
  })
    .on("reduce", (result: any) => {
      stats.push(result.stats);

      collectionNotWithin.features = collectionNotWithin.features.concat(
        result.featuresNotWithin
      );
    })
    .on("end", function () {
      fs.writeFileSync(`${directory}/stats.json`, JSON.stringify(stats));

      const file = path.resolve(directory, "diff.geojson");
      const stream = fs.createWriteStream(file);

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
      console.log(`Result: ${file}`);
    });
} catch (err) {
  console.error(err);
  process.exit(1);
}
