"use strict";

import es from "event-stream";
import fs from "fs";
import { Feature } from "geojson";
import JSONStream from "jsonstream-next";
import path from "path";
import buffer from "@turf/buffer";

import fileExists from "./file-exists";

const args = process.argv.slice(2);

const source = args[0];
const target = args[1];

console.log(`Source: ${path.resolve(args[0])}`);
console.log(`Target: ${path.resolve(args[1])}`);

if (fileExists(args[0], args[1]) !== true) process.exit(1);

const directory = path.dirname(source);

fs.createReadStream(source)
  .pipe(JSONStream.parse("features.*"))
  .pipe(
    es.mapSync((feature: Feature) => buffer(feature, 20, { units: "meters" }))
  )
  .pipe(
    JSONStream.stringify(
      '{"type":"FeatureCollection","features":[\n',
      ",\n",
      "\n]}"
    )
  )
  .pipe(fs.createWriteStream(`${directory}/${target}`));

console.log(fs.realpathSync(`${directory}/${target}`));
