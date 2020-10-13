"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const geojson_normalize_1 = __importDefault(require("@mapbox/geojson-normalize"));
const boolean_within_1 = __importDefault(require("@turf/boolean-within"));
const flatten_1 = __importDefault(require("@turf/flatten"));
const union_1 = __importDefault(require("@turf/union"));
module.exports = (sources, tile, write, done) => {
    const roads = flatten_1.default(geojson_normalize_1.default(sources.road.roads));
    const buffers = flatten_1.default(geojson_normalize_1.default(sources.buffer.buffers));
    // write(tile);
    // let buffer = buffers.features[0] as Feature<Polygon, Properties>;
    // buffers.features.shift();
    // buffers.features.forEach((feature) => {
    //   buffer = turf.union(buffer, feature as Feature<Polygon, Properties>);
    // });
    const mergedBuffers = union_1.default(...buffers.features);
    const featuresNotWithin = roads.features.filter((feature) => boolean_within_1.default(feature, mergedBuffers) !== true);
    const stats = {
        tile,
        roads: roads.features.length,
        buffers: buffers.features.length,
        notWithin: featuresNotWithin.length,
    };
    done(null, { stats, featuresNotWithin, mergedBuffers });
};
