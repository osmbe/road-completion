<script>
  import Chart from './Statistics/Chart.svelte';
  import Table from './Statistics/Table.svelte';

  export let commits;
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