"use strict";

import es from "event-stream";
import fs from "fs";
import { Feature } from "geojson";
import JSONStream from "jsonstream-next";
import minimist from "minimist";
import path from "path";

const options = minimist(process.argv.slice(2));
const source = options._[0];
const target = options._[1];

const directory = path.dirname(source);

const convert = JSON.parse(fs.readFileSync(options.c).toString());
const convertKeys = Object.keys(convert);

fs.createReadStream(source)
  .pipe(JSONStream.parse("features.*"))
  .pipe(
    es.mapSync((feature: Feature) => {
      let properties: { [index: string]: any } = {};
      let tags: { [index: string]: any } = {};

      if (feature.properties !== null) {
        Object.keys(feature.properties).forEach((key: string) => {
          if (feature.properties !== null) {
            const value = feature.properties[key];

            properties[`original:${key}`] = value;

            if (convertKeys.indexOf(key) !== -1) {
              if (typeof convert[key][value] !== "undefined") {
                tags = Object.assign(tags, convert[key][value]);
              } else if (typeof convert[key]["*"] !== "undefined") {
                tags = Object.assign(tags, convert[key]["*"]);
              }
            }
          }
        });
      }

      feature.properties = Object.assign(tags, properties);

      return feature;
    })
  )
  .pipe(
    JSONStream.stringify(
      '{"type":"FeatureCollection","features":[\n',
      ",\n",
      "\n]}"
    )
  )
  .pipe(fs.createWriteStream(`${directory}/${target}`));
