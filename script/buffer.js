"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const event_stream_1 = __importDefault(require("event-stream"));
const fs_1 = __importDefault(require("fs"));
const jsonstream_next_1 = __importDefault(require("jsonstream-next"));
const path_1 = __importDefault(require("path"));
const buffer_1 = __importDefault(require("@turf/buffer"));
const args = process.argv.slice(2);
const source = args[0];
const target = args[1];
const directory = path_1.default.dirname(source);
fs_1.default.createReadStream(source)
    .pipe(jsonstream_next_1.default.parse("features.*"))
    .pipe(event_stream_1.default.mapSync((feature) => buffer_1.default(feature, 20, { units: "meters" })))
    .pipe(jsonstream_next_1.default.stringify('{"type":"FeatureCollection","features":[\n', ",\n", "\n]}"))
    .pipe(fs_1.default.createWriteStream(`${directory}/${target}`));
console.log(fs_1.default.realpathSync(`${directory}/${target}`));
