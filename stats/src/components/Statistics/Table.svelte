<script>
  import moment from 'moment';

  export let commits;
</script>

<table class="table is-fullwidth is-striped">
  <thead>
    <tr>
      <th colspan="2">Commit</th>
      <th>Date</th>
      <th>Roads</th>
      <th>OSM</th>
      <th>"Missing"</th>
      <th>Tiles</th>
    </tr>
  </thead>
  <tbody>
    {#each commits as commit}
    <tr>
      {#if commit.status == 'script'}
      <td class="has-text-center has-tooltip" title="Process has been updated">🔨</td>
      {:else}
      <td></td>
      {/if}
      <td>
        <a target="_blank" rel="external" href="{ commit.url }">
          { commit.title || commit.message }
        </a>
      </td>
      <td class="nowrap">
        <time class="has-tooltip" datetime="{ moment(commit.datetime).format() }"
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