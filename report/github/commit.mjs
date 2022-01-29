import { Octokit } from '@octokit/rest';

import { OWNER, REPOSITORY } from './constants.mjs';

export default async function (ref) {
  const octokit = new Octokit({
    auth: process.env.PUBLIC_GITHUB_TOKEN || null
  });

  const { data } = await octokit.repos.getCommit({
    owner: OWNER,
    repo: REPOSITORY,
    ref
  });

  return data;
}
