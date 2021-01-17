import { Octokit } from "@octokit/rest";

import { OWNER, REPOSITORY } from "../constants";

export default async function (ref) {
  const octokit = new Octokit({
    auth: process.env.TOKEN || null
  });

  const { data } = await octokit.repos.getCommit({
    owner: OWNER,
    repo: REPOSITORY,
    ref
  });

  return data;
}