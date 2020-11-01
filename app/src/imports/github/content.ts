import { Octokit } from "@octokit/rest";

import { OWNER, REPOSITORY } from "../constants";

export default async function (path: string, ref: string) {
  const octokit = new Octokit({
    auth: process.env.GITHUB_TOKEN
  });

  const response = await octokit.repos.getContent({
    owner: OWNER,
    repo: REPOSITORY,
    path,
    ref
  });

  return JSON.parse(Buffer.from(response.data.content, response.data.encoding as BufferEncoding).toString('utf-8'));
}