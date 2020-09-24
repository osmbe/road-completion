"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const event_stream_1 = __importDefault(require("event-stream"));
const fs_1 = __importDefault(require("fs"));
const jsonstream_next_1 = __importDefault(require("jsonstream-next"));
const path_1 = __importDefault(require("path"));
const args = process.argv.slice(2);
const source = args[0];
const target = args[1];
const directory = path_1.default.dirname(source);
const convert = JSON.parse(fs_1.default.readFileSync(path_1.default.dirname(directory) + "/convert.json").toString());
const convertKeys = Object.keys(convert);
fs_1.default.createReadStream(source)
    .pipe(jsonstream_next_1.default.parse("features.*"))
    .pipe(event_stream_1.default.mapSync((feature) => {
    let properties = {};
    let tags = {};
    if (feature.properties !== null) {
        Object.keys(feature.properties).forEach((key) => {
            if (feature.properties !== null) {
                const value = feature.properties[key];
                properties[`original:${key}`] = value;
                if (convertKeys.indexOf(key) !== -1) {
                    if (typeof convert[key][value] !== "undefined") {
                        tags = Object.assign(tags, convert[key][value]);
                    }
                    else if (typeof convert[key]["*"] !== "undefined") {
                        tags = Object.assign(tags, convert[key]["*"]);
                    }
                }
            }
        });
    }
    feature.properties = Object.assign(tags, properties);
    return feature;
}))
    .pipe(jsonstream_next_1.default.stringify('{"type":"FeatureCollection","features":[\n', ",\n", "\n]}"))
    .pipe(fs_1.default.createWriteStream(`${directory}/${target}`));
