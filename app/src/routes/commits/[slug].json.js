import getCommits from '../../imports/github/commits';
import { PATHS } from '../../imports/constants';

export async function get (req, res, next) {
  const { slug } = req.params;

  const commits = await getCommits(PATHS[slug]);

  if (commits.length > 0) {
    res.writeHead(200, {
      'Content-Type': 'application/json'
    });

    res.end(JSON.stringify(commits));
  } else {
    res.writeHead(404, {
      'Content-Type': 'application/json'
    });

    res.end(JSON.stringify({ message: 'Not found' }));
  }
}
