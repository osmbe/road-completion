<script>
  import moment from 'moment';

  export let commits;
</script>

<style>
  time {
    cursor: help;
  }
</style>

<table class="table is-striped">
  <thead>
    <tr>
      <th>Commit</th>
      <th>Date</th>
      <th>Roads</th>
      <th>OpenStreetMap</th>
      <th>"Missing" roads</th>
    </tr>
  </thead>
  <tbody>
    {#each commits as commit}
    <tr>
      <td>
        <a target="_blank" rel="external" href="{ commit.url }">
          { commit.message }
        </a>
      </td>
      <td>
        <time datetime="{ moment(commit.datetime).format() }"
          title="{ moment(commit.datetime).format('dddd, MMMM Do YYYY, HH:mm:ss') }">
          { moment(commit.datetime).fromNow() }
        </time>
      </td>
      <td class="has-text-right">{ commit.stats.roads }</td>
      <td class="has-text-right">{ commit.stats.buffers }</td>
      <td class="has-text-right">{ commit.stats.notWithin }</td>
    </tr>
    {/each}
  </tbody>
</table>