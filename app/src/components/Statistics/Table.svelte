<script>
  import moment from 'moment';

  export let commits;
</script>

<style>
  time {
    cursor: help;
  }

  td.nowrap {
    white-space: nowrap;
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
      <th>Tiles</th>
    </tr>
  </thead>
  <tbody>
    {#each commits as commit}
    <tr>
      <td>
        <a target="_blank" rel="external" href="{ commit.url }">
          { commit.title || commit.message }
        </a>
      </td>
      <td class="nowrap">
        <time datetime="{ moment(commit.datetime).format() }"
          title="{ moment(commit.datetime).format('dddd, MMMM Do YYYY, HH:mm:ss') }">
          { moment(commit.datetime).fromNow() }
        </time>
      </td>
      <td class="has-text-right">{ commit.stats.roads }</td>
      <td class="has-text-right">{ commit.stats.buffers }</td>
      <td class="has-text-right">
        <a target="_blank" rel="external" href="{ commit.diff }">
        { commit.stats.notWithin }
        </a>
      </td>
      <td class="has-text-right">{ commit.stats.tiles }</td>
    </tr>
    {/each}
  </tbody>
</table>