<script lang="ts">
  import { onMount } from "svelte";

  export let commits: Array<{ path: string; diff: string; datetime: Date; title: string; message: string; sha: string, url: string; stats: any; status: string; }>;

  let container: HTMLCanvasElement;

  onMount(async () => {
    const { default: Chart } = await import("chart.js");

    const data = commits.map((commit) => {
      return {
        t: commit.datetime,
        y: commit.stats.notWithin
      }
    });

    new Chart(container, {
      type: 'line',
      data: {
        datasets: [{
          data,
          cubicInterpolationMode: "monotone",
          fill: true,
        }]
      },
      options: {
        legend: {
          display: false
        },
        scales: {
          xAxes: [{
            type: 'time',
            ticks: {
              max: new Date()
            },
            time: {
              unit: 'week',
              tooltipFormat: 'dddd, MMMM Do YYYY, HH:mm:ss'
            }
          }],
          yAxes: [{
            ticks: {
              beginAtZero: true
            }
          }]
        }
      }
    });
  });
</script>

<style>
</style>

<canvas bind:this="{container}"></canvas>