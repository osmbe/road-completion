import { Octokit } from '@octokit/rest';

import { OWNER, REPOSITORY } from './constants.mjs';

export default async function (path, ref) {
  const octokit = new Octokit({
    auth: process.env.PUBLIC_GITHUB_TOKEN || null
  });

  const { data } = await octokit.repos.getContent({
    owner: OWNER,
    repo: REPOSITORY,
    path,
    ref
  });

  return typeof data.content !== 'undefined' ? JSON.parse(Buffer.from(data.content, data.encoding).toString('utf-8')) : [];
}
