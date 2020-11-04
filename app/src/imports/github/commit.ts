import { Octokit } from "@octokit/rest";

import { OWNER, REPOSITORY } from "../constants";

export default async function (ref: string) {
  const octokit = new Octokit({
    auth: process.env.GITHUB_TOKEN || null
  });

  const response = await octokit.repos.getCommit({
    owner: OWNER,
    repo: REPOSITORY,
    ref
  });

  return response.data;
}