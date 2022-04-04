import Chart from 'chart.js/auto';
import ChartDataLabels from 'chartjs-plugin-datalabels';

const initChart = () => {

  document.addEventListener('turbolinks:load', () => {
    Chart.register(ChartDataLabels);
    Chart.defaults.font.size = 12;
    Chart.defaults.font.family = 'Montserrat';
    // Chart.canvas.parentNode.style.height = '128px';
    // Chart.canvas.parentNode.style.width = '128px';

    const ctx4 = document.getElementById("Win-rate-Chart").getContext('2d');
    const WinRateChart = new Chart(ctx4, {
      type: 'doughnut',
      data: {
        labels: JSON.parse(ctx4.canvas.dataset.labels).reverse(),
        datasets: [{
          data: JSON.parse(ctx4.canvas.dataset.data).reverse(),
          borderWidth: 1,
          backgroundColor: ["#D0D0D0", "#21B6A8"],
        }]
      },
      options: {
        responsive: true,
        borderDash: [10, 10],
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
            display: false,
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
            color: 'white',
            font: {
              family: 'Montserrat',
              size: 16,
              weight: 'bold'
            },
            formatter: function (value, context) {
              return `${value} %`
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

    WinRateChart.resize(300, 300)

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
        borderDash: [10, 10],
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
            formatter: function (value, context) {
              return value.toLocaleString()
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
        borderDash: [10, 10],
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
            formatter: function (value, context) {
              return value.toLocaleString()
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
        borderDash: [10, 10],
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
            formatter: function (value, context) {
              return value.toLocaleString()
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
}

export { initChart }
