"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const tile_reduce_1 = __importDefault(require("@mapbox/tile-reduce"));
const fs_1 = __importDefault(require("fs"));
const path_1 = __importDefault(require("path"));
function writeFile() { }
const args = process.argv.slice(2);
const directory = path_1.default.dirname(args[0]);
const options = {
    sourceCover: "road",
    log: true,
    map: path_1.default.join(__dirname, "difference/buffer.js"),
    sources: [
        {
            name: "buffer",
            mbtiles: fs_1.default.realpathSync(args[1]),
            layers: ["buffers"],
        },
        {
            name: "road",
            mbtiles: fs_1.default.realpathSync(args[0]),
            layers: ["roads"],
        },
    ],
};
let collectionNotWithin = {
    type: "FeatureCollection",
    features: [],
};
let mergedBuffers;
let stats = [];
tile_reduce_1.default(options)
    .on("reduce", (result) => {
    stats.push(result.stats);
    collectionNotWithin.features = collectionNotWithin.features.concat(result.featuresNotWithin);
})
    .on("end", function () {
    fs_1.default.writeFileSync(`${directory}/stats.json`, JSON.stringify(stats));
    const stream = fs_1.default.createWriteStream(`${directory}/notWithin.geojson`);
    stream.write('{"type":"FeatureCollection","features":[\n');
    collectionNotWithin.features.forEach((feature, index) => {
        stream.write(JSON.stringify(feature));
        if (index < collectionNotWithin.features.length - 1) {
            stream.write(",\n");
        }
    });
    stream.write("\n]}");
    stream.end();
    console.log("Features count: %d", collectionNotWithin.features.length);
});
