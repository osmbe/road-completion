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
    <a target="_blank" href="https://github.com/osmbe/road-completion/">Road Completion</a>
  </h1>

  <hr>

  <ul>
    <li><a href="#be-brussels">🇧🇪 Brussels, Belgium</a> 🤖</li>
    <li><a href="#be-flanders">🇧🇪 Flanders, Belgium</a> 🤖</li>
    <li><a href="#be-wallonia">🇧🇪 Wallonia, Belgium</a></li>
    <li><a href="#luxembourg">🇱🇺 Luxembourg</a> 🤖</li>
    <li><a href="#netherlands">🇳🇱 Netherlands</a> 🤖</li>
    <li><a href="#kosovo">🇽🇰 Kosovo</a></li>
  </ul>

  <hr>

  <h2 class="title is-2">🇧🇪 Belgium</h2>
  <h3 class="title is-3" id="be-brussels">
    Bruxelles/Brussel (Brussels)
    <a target="_blank" href="https://github.com/osmbe/road-completion/actions/workflows/belgium-brussels.yml">
      <img alt="GitHub Actions workflow" src="https://github.com/osmbe/road-completion/actions/workflows/belgium-brussels.yml/badge.svg">
    </a>
  </h3>
  <Statistics commits={commits[0]}></Statistics>

  <hr>

  <h3 class="title is-3" id="be-flanders">
    Vlaanderen (Flanders)
    <a target="_blank" href="https://github.com/osmbe/road-completion/actions/workflows/belgium-flanders.yml">
      <img alt="GitHub Actions workflow" src="https://github.com/osmbe/road-completion/actions/workflows/belgium-flanders.yml/badge.svg">
    </a>
  </h3>
  <Statistics commits={commits[1]}></Statistics>

  <hr>

  <h3 class="title is-3" id="be-wallonia">Wallonie (Wallonia)</h3>
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

  <h2 class="title is-2" id="luxembourg">
    🇱🇺 Luxembourg
    <a target="_blank" href="https://github.com/osmbe/road-completion/actions/workflows/luxembourg.yml">
      <img alt="GitHub Actions workflow" src="https://github.com/osmbe/road-completion/actions/workflows/luxembourg.yml/badge.svg">
    </a>
  </h2>
  <Statistics commits={commits[7]}></Statistics>

  <hr>

  <h2 class="title is-2" id="netherlands">
    🇳🇱 Netherlands
    <a target="_blank" href="https://github.com/osmbe/road-completion/actions/workflows/netherlands.yml">
      <img alt="GitHub Actions workflow" src="https://github.com/osmbe/road-completion/actions/workflows/netherlands.yml/badge.svg">
    </a>
  </h2>
  <Statistics commits={commits[8]}></Statistics>

  <hr>

  <h2 class="title is-2" id="kosovo">🇽🇰 Kosovo</h2>
  <Statistics commits={commits[9]}></Statistics>

</div>