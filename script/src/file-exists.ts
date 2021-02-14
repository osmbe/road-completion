'use strict';

import fs from 'fs';
import path from 'path';

export default function (...files: string[]): boolean {
  let exists = true;

  files.forEach((file) => {
    const fullPath = path.resolve(file);

    try {
      fs.accessSync(fullPath, fs.constants.F_OK | fs.constants.R_OK);
    } catch (err) {
      console.error(`File "${fullPath}" does not exist or is not readable.`);
      exists = false;
    }
  });

  return exists;
}
