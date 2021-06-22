'use strict'

const fs = require('fs');
const crypto = require('crypto');

var args = process.argv.slice(2);
const source = args[0];
const target = args[1];

const data = JSON.parse(fs.readFileSync(source, 'utf8'));

data['features'].forEach(element => {
    let uid = hashProperties(element['geometry']);
    element['properties']['original:uid'] = uid;
});

function hashProperties(properties) {
    let mergedCoordinates = "";
    properties.coordinates.forEach(element => {
      mergedCoordinates += element[0] + element[1];
    });
    let hash = crypto.createHash('md5').update(mergedCoordinates).digest('hex');
    return hash;
}

fs.writeFileSync(target, JSON.stringify(data));