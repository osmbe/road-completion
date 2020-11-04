<script context="module" lang="ts">
  export function preload() {
    return this.fetch(`commits.json`)
      .then((r: Response) => r.json())
      .then((commits: Record<string, Array<{ path: string; diff: string; datetime: Date; title: string; message: string; sha: string, url: string; stats: any; status: string; }>>) => {
        return { commits }
      });
  }
</script>

<script lang="ts">
  import Statistics from '../components/Statistics.svelte';

  export let commits: Record<string, Array<{ path: string; diff: string; datetime: Date; title: string; message: string; sha: string, url: string; stats: any; status: string; }>>;
</script>

<svelte:head>
  <title>Road Completion</title>
</svelte:head>

<div class="container">

  <h1 class="title is-1">Road Completion</h1>

  <hr>

  <h2 class="title is-2">Belgium</h2>
  <h3 class="title is-3">Bruxelles/Brussel (Brussels)</h3>
  <Statistics commits={commits['be-brussels']}></Statistics>

  <hr>

  <h3 class="title is-3">Vlaanderen (Flanders)</h3>
  <Statistics commits={commits['be-flanders']}></Statistics>

  <hr>

  <h3 class="title is-3">Wallonie (Wallonia)</h3>
  <h4 class="subtitle is-4">Brabant-Wallon</h4>
  <Statistics commits={commits['be-wallonia-bra']}></Statistics>
  <h4 class="subtitle is-4">Hainaut</h4>
  <Statistics commits={commits['be-wallonia-hai']}></Statistics>
  <h4 class="subtitle is-4">Liège</h4>
  <Statistics commits={commits['be-wallonia-lie']}></Statistics>
  <h4 class="subtitle is-4">Luxembourg</h4>
  <Statistics commits={commits['be-wallonia-lux']}></Statistics>
  <h4 class="subtitle is-4">Namur</h4>
  <Statistics commits={commits['be-wallonia-nam']}></Statistics>

  <hr>

  <h2 class="title is-2">Kosovo</h2>
  <Statistics commits={commits['xk']}></Statistics>

</div>