import { Octokit } from '@octokit/rest';

import { OWNER, REPOSITORY } from '../constants';

export default async function (path, ref) {
  const octokit = new Octokit({
    auth: process.env.TOKEN || null
  });

  const { data } = await octokit.repos.getContent({
    owner: OWNER,
    repo: REPOSITORY,
    path,
    ref
  });

  return JSON.parse(Buffer.from(data.content, data.encoding).toString('utf-8'));
}
