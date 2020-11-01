import { Octokit } from "@octokit/rest";

import getContent from "./content";

import { OWNER, REPOSITORY } from "../constants";

export default async function (path: string) {
  const octokit = new Octokit({
    auth: process.env.GITHUB_TOKEN || null
  });

  const response = await octokit.repos.listCommits({
    owner: OWNER,
    repo: REPOSITORY,
    path
  });

  return Promise.all(
    response.data.map(async (commit) => {
      const content = await getContent(path, commit.sha);

      const stats = content.reduce((sum, value) => {
        sum.roads += value.roads;
        sum.buffers += value.buffers;
        sum.notWithin += value.notWithin;

        return sum;
      });

      const dirname = path.match(/.*\//);
      const diff = `https://github.com/${OWNER}/${REPOSITORY}/blob/${commit.sha}/${dirname}diff.geojson`;

      return {
        path,
        diff,
        datetime: new Date(commit.commit.author.date),
        message: commit.commit.message,
        sha: commit.sha,
        url: commit.html_url,
        stats
      };
    })
  );
}