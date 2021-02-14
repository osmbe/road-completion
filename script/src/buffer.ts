'use strict';

import buffer from '@turf/buffer';
import es from 'event-stream';
import fs from 'fs';
import { Feature } from 'geojson';
import JSONStream from 'jsonstream-next';
import minimist from 'minimist';
import path from 'path';

import fileExists from './file-exists';

const options = minimist(process.argv.slice(2));
const source = options._[0];
const target = options._[1];
const radius = options.r ?? options.radius;

console.log(`Source: ${path.resolve(source)}`);
console.log(`Radius: ${radius}m.`);

if (fileExists(source) !== true) process.exit(1);

const directory = path.dirname(source);

console.log(path.resolve(directory, target));

fs.createReadStream(source)
  .pipe(JSONStream.parse('features.*'))
  .pipe(
    es.mapSync((feature: Feature) => buffer(feature, radius, { units: 'meters' }))
  )
  .pipe(
    JSONStream.stringify(
      '{"type":"FeatureCollection","features":[\n',
      ',\n',
      '\n]}'
    )
  )
  .pipe(fs.createWriteStream(path.resolve(directory, target)));
