'use strict'

const fs = require('fs');

var args = process.argv.slice(2);
const sourceA = args[0];
const sourceB = args[1];
const append = args[2];
const target = args[3];

function convert_csv_tuples_to_json(filePath) {
    const data = fs.readFileSync(filePath, 'utf8');
    let inputRows = data.split(/\r?\n/);
    
    let result = {}
    
    inputRows.forEach(element => {
        if(element.charAt(0) === "#") {
            return;
        }
        var [id, name] = element.split(/\t/);
        result[id] = {"name": name};
    });

    return result;
}

let normalizeNames = { 
    NOM_RUE: convert_csv_tuples_to_json(sourceA),
    ID_RUE_CAC: convert_csv_tuples_to_json(sourceB)
};

const convertTags = JSON.parse(fs.readFileSync(append, 'utf8'));
let data = JSON.stringify({
    ...convertTags,
    ...normalizeNames
});

fs.writeFileSync(target, data);