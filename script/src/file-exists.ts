"use strict";

import { F_OK, R_OK } from "constants";
import fs from "fs";
import path from "path";

export default function (...files: string[]) {
  let exists = true;

  files.forEach((file) => {
    const fullPath = path.resolve(file);

    try {
      fs.accessSync(fullPath, F_OK | R_OK);
    } catch (err) {
      console.error(`File "${fullPath}" does not exist or is not readable.`);
      exists = false;
    }
  });

  return exists;
}
