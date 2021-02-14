'use strict';

import normalize from '@mapbox/geojson-normalize';
import booleanWithin from '@turf/boolean-within';
import flatten from '@turf/flatten';
import { Feature, FeatureCollection, Polygon, Properties } from '@turf/helpers';
import union from '@turf/union';

module.exports = (
  sources: Record<
    'buffer' | 'road',
    Record<'buffers' | 'roads', FeatureCollection>
  >,
  tile: [number, number, number],
  write: any,
  done: any
) => {
  const stats = {
    tile,
    roads: 0,
    buffers: 0,
    notWithin: 0
  };

  try {
    const roads: any = flatten(normalize(sources.road.roads));
    const buffers: any = flatten(normalize(sources.buffer.buffers));

    stats.roads = roads.features.length;
    stats.buffers = buffers.features.length;

    const mergedBuffers = union(
      ...(buffers.features as Feature<Polygon, Properties>[])
    );

    const featuresNotWithin = roads.features.filter(
      (feature: Feature) => booleanWithin(feature, mergedBuffers) !== true
    );

    stats.notWithin = featuresNotWithin.length;

    done(null, { stats, featuresNotWithin });
  } catch (err) {
    // @todo Should do something with the error
    done(null, { stats, featuresNotWithin: null });
  }
};
