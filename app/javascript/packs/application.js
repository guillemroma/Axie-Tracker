// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import Chart from 'chart.js/auto';
import ChartDataLabels from 'chartjs-plugin-datalabels';


Rails.start()
Turbolinks.start()
ActiveStorage.start()


import "controllers"
import "bootstrap"

document.addEventListener('turbolinks:load', () => {
    Chart.register(ChartDataLabels);
    Chart.defaults.font.size = 12;
    Chart.defaults.font.family = 'Montserrat';
    // Chart.canvas.parentNode.style.height = '128px';
    // Chart.canvas.parentNode.style.width = '128px';

    const ctx = document.getElementById('SLP-Chart').getContext('2d');
    const SLPChart = new Chart(ctx, {
      type: 'line',
      data: {
        labels: JSON.parse(ctx.canvas.dataset.labels).reverse(),
        datasets: [{
          data: JSON.parse(ctx.canvas.dataset.data).reverse(),
          borderWidth: 1
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          y: {
            display: false,
            beginAtZero: true,
            grace: '30%',
            grid: {
              display: false
            }
          },
          x: {
            grid: {
              display: false
            },
            font: {
              color: 'red',
              size: 6
            }
          }
        },
        plugins: {
          legend: {
            display: false
          },
          datalabels: {
            backgroundColor: '#21B6A8',
            borderRadius: 50,
            padding: 10,
            color: 'white',
            font: {
              family: 'Montserrat',
              size: 13,
              weight: 'bold'
            }
          }
        },
        elements: {
          point: {
            backgroundColor: '#21B6A8',
            radius: 0.5
          },
          line: {
            borderWidth: 1,
            borderColor: '#21B6A8'
          }
        }
      }
    }
    );
    SLPChart.resize(300, 300)

    const ctx2 = document.getElementById('MMR-Chart').getContext('2d');
    const MMRChart = new Chart(ctx2, {
      type: 'line',
      data: {
        labels: JSON.parse(ctx2.canvas.dataset.labels).reverse(),
        datasets: [{
          data: JSON.parse(ctx2.canvas.dataset.data).reverse(),
          borderWidth: 1
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          y: {
            display: false,
            beginAtZero: true,
            grace: '30%',
            grid: {
              display: false
            }
          },
          x: {
            grid: {
              display: false
            },
            font: {
              color: 'red',
              size: 6
            }
          }
        },
        plugins: {
          legend: {
            display: false
          },
          datalabels: {
            backgroundColor: '#21B6A8',
            borderRadius: 50,
            padding: 10,
            color: 'white',
            font: {
              family: 'Montserrat',
              size: 13,
              weight: 'bold'
            },
          }
        },
        elements: {
          point: {
            backgroundColor: '#21B6A8',
            radius: 0.5
          },
          line: {
            borderWidth: 1,
            borderColor: '#21B6A8'
          }
        }
      }
    }
    );

    MMRChart.resize(300, 300)

    const ctx3 = document.getElementById('Ranking-Chart').getContext('2d');
    const RankingChart = new Chart(ctx3, {
      type: 'line',
      data: {
        labels: JSON.parse(ctx3.canvas.dataset.labels).reverse(),
        datasets: [{
          data: JSON.parse(ctx3.canvas.dataset.data).reverse(),
          borderWidth: 1
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          y: {
            display: false,
            beginAtZero: true,
            grace: '30%',
            grid: {
              display: false
            }
          },
          x: {
            grid: {
              display: false
            },
            font: {
              color: 'red',
              size: 6
            }
          }
        },
        plugins: {
          legend: {
            display: false
          },
          datalabels: {
            backgroundColor: '#21B6A8',
            borderRadius: 50,
            padding: 10,
            color: 'white',
            font: {
              family: 'Montserrat',
              size: 13,
              weight: 'bold'
            },
            formatter: function(value, context) {
              console.log(value)
              console.log(value + 1)
              console.log(context.chart.data.datasets[0].data[context.dataIndex])
              return context.chart.data.datasets[0].data[context.dataIndex]

            }
          }
        },
        elements: {
          point: {
            backgroundColor: '#21B6A8',
            radius: 0.5
          },
          line: {
            borderWidth: 1,
            borderColor: '#21B6A8'
          }
        }
      }
    }
    );

    RankingChart.resize(300, 300)

   }
  )
