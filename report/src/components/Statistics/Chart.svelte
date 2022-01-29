<script>
  import { onMount } from 'svelte';

  export let id;

  let container;

  onMount(async () => {
    const Chart = await import('chart.js/auto');
    await import('chartjs-adapter-moment');

    const response = await fetch(`data/${id}.json`);
    const commits = await response.json();

    const data = commits.map((commit) => {
      return {
        x: commit.datetime,
        y: commit.stats.notWithin
      }
    });

    new Chart.default(container, {
      type: 'line',
      data: {
        datasets: [{
          data,
          cubicInterpolationMode: 'monotone',
          fill: true,
        }]
      },
      options: {
        maintainAspectRatio: false,
        plugins: {
          legend: {
            display: false
          },
        },
        scales: {
          x: {
            type: 'time',
            max: new Date(),
            time: {
              displayFormats: {
                month: 'MMM YYYY'
              }
            }
          },
          y: {
            beginAtZero: true,
            ticks: {
              precision: 0
            }
          }
        }
      }
    });
  });
</script>

<div id={`${id}-chart`} style="height: 150px;">
  <canvas bind:this='{container}'></canvas>
</div>
