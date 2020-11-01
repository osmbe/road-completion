import sirv from 'sirv';
import polka from 'polka';
import compression from 'compression';
import * as sapper from '@sapper/server';

const { PORT, NODE_ENV, GITHUBIO } = process.env;
const dev = NODE_ENV === 'development';
const githubio = GITHUBIO === 'true';

polka() // You can also use Express
  .use(
    githubio ? 'road-completion' : '/',
    compression({ threshold: 0 }),
    sirv('static', { dev }),
    sapper.middleware()
  )
  .listen(PORT, err => {
    if (err) console.log('error', err);
  });
