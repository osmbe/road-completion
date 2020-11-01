<script>
  export let status;
  export let error;

  const dev = process.env.NODE_ENV === 'development';
</script>

<svelte:head>
  <title>{status}</title>
</svelte:head>

<div class="container">
  <h1 class="title is-1">{status}</h1>

  <article class="message">
    <div class="message-header">
      <p>{error.message}</p>
    </div>
    <div class="message-body">
      {#if dev && error.stack}
      <pre>{error.stack}</pre>
      {/if}
    </div>
  </article>
</div>