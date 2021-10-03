<script>
  import { onMount } from "svelte";

  export let commits;

  let container;

  onMount(async () => {
    const Chart = await import("chart.js/auto");
    await import("chartjs-adapter-moment");

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
          cubicInterpolationMode: "monotone",
          fill: true,
        }]
      },
      options: {
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

<style>
</style>

<canvas bind:this="{container}"></canvas>