"use strict";

import normalize from "@mapbox/geojson-normalize";
import booleanWithin from "@turf/boolean-within";
import flatten from "@turf/flatten";
import { Feature, FeatureCollection, Polygon, Properties } from "@turf/helpers";
import union from "@turf/union";

module.exports = (
  sources: Record<
    "buffer" | "road",
    Record<"buffers" | "roads", FeatureCollection>
  >,
  tile: [number, number, number],
  write: Function,
  done: Function
) => {
  const roads: any = flatten(normalize(sources.road.roads));
  const buffers: any = flatten(normalize(sources.buffer.buffers));

  // write(tile);

  // let buffer = buffers.features[0] as Feature<Polygon, Properties>;
  // buffers.features.shift();
  // buffers.features.forEach((feature) => {
  //   buffer = turf.union(buffer, feature as Feature<Polygon, Properties>);
  // });

  const mergedBuffers = union(
    ...(buffers.features as Feature<Polygon, Properties>[])
  );

  const featuresNotWithin = roads.features.filter(
    (feature: Feature) => booleanWithin(feature, mergedBuffers) !== true
  );

  const stats = {
    tile,
    roads: roads.features.length,
    buffers: buffers.features.length,
    notWithin: featuresNotWithin.length,
  };

  done(null, { stats, featuresNotWithin, mergedBuffers });
};
