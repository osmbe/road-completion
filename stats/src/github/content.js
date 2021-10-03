import.meta.hot;

import { Octokit } from '@octokit/rest';

import { OWNER, REPOSITORY } from '../constants';

export default async function (path, ref) {
  const octokit = new Octokit({
    auth: __SNOWPACK_ENV__.SNOWPACK_PUBLIC_TOKEN || null
  });

  const { data } = await octokit.repos.getContent({
    owner: OWNER,
    repo: REPOSITORY,
    path,
    ref
  });

  return typeof data.content !== 'undefined' ? JSON.parse(Buffer.from(data.content, data.encoding).toString('utf-8')) : [];
}
