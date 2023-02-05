import { createActionAuth } from '@octokit/auth-action';
import { Octokit } from '@octokit/rest';

import { OWNER, REPOSITORY } from './constants.mjs';

export default async function (auth, ref) {
  const octokit = new Octokit({
    authStrategy: createActionAuth,
    auth,
  });

  const { data } = await octokit.repos.getCommit({
    owner: OWNER,
    repo: REPOSITORY,
    ref
  });

  return data;
}
