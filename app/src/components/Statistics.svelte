<script lang="ts">
  import Chart from './Statistics/Chart.svelte';
  import Table from './Statistics/Table.svelte';

  export let commits: Array<{ path: string; diff: string; datetime: Date; title: string; message: string; sha: string, url: string; stats: any; status: string; }>;
</script>

<style>
  .columns {
    max-height: 300px;
  }

  .column {
    overflow-y: auto;
  }
</style>

<div class="columns">
  <div class="column is-4">
    <Chart {commits} />
  </div>
  <div class="column">
    <Table {commits} />
  </div>
</div>