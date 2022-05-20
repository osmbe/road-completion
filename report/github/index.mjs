import { writeFile } from "fs";

import getCommits from "./commits.mjs";

import { PATHS } from "./constants.mjs";

Object.keys(PATHS).forEach(async (key) => {
  const data = await getCommits(PATHS[key]);
  const json = JSON.stringify(data);

  writeFile(`public/data/${key}.json`, json, (err) => {
    if (err) throw err;
    console.log(`✅ The file "${key}.json" has been saved!`);
  });
});
