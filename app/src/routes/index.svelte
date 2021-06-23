<script context="module">
  import { PATHS } from "../imports/constants";

  export async function preload() {
    const promises = Object.keys(PATHS).map(async (slug) => {
      const response = await this.fetch(`commits/${slug}.json`);
      const json = await response.json();
      return json;
    });

    const commits = await Promise.all(promises);

    return { commits }
  }
</script>

<script>
  import Statistics from '../components/Statistics.svelte';

  export let commits;
</script>

<style>
</style>

<svelte:head>
  <title>Road Completion</title>
</svelte:head>

<div class="container">

  <h1 class="title is-1">
    <a href=".">Road Completion</a>
  </h1>

  <hr>

  <h2 class="title is-2">Belgium</h2>
  <h3 class="title is-3">Bruxelles/Brussel (Brussels)</h3>
  <Statistics commits={commits[0]}></Statistics>

  <hr>

  <h3 class="title is-3">Vlaanderen (Flanders)</h3>
  <Statistics commits={commits[1]}></Statistics>

  <hr>

  <h3 class="title is-3">Wallonie (Wallonia)</h3>
  <h4 class="subtitle is-4">Brabant-Wallon</h4>
  <Statistics commits={commits[2]}></Statistics>
  <h4 class="subtitle is-4">Hainaut</h4>
  <Statistics commits={commits[3]}></Statistics>
  <h4 class="subtitle is-4">Liège</h4>
  <Statistics commits={commits[4]}></Statistics>
  <h4 class="subtitle is-4">Luxembourg</h4>
  <Statistics commits={commits[5]}></Statistics>
  <h4 class="subtitle is-4">Namur</h4>
  <Statistics commits={commits[6]}></Statistics>

  <hr>

  <h2 class="title is-2">Luxembourg</h2>
  <Statistics commits={commits[7]}></Statistics>

  <hr>

  <h2 class="title is-2">Netherlands</h2>
  <Statistics commits={commits[8]}></Statistics>

  <hr>

  <h2 class="title is-2">Kosovo</h2>
  <Statistics commits={commits[9]}></Statistics>

</div>