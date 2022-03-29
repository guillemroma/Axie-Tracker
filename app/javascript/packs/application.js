// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import Chart from 'chart.js/auto';


Rails.start()
Turbolinks.start()
ActiveStorage.start()


document.addEventListener('turbolinks:load', () => {
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
        maintainAspectRatio: false,
      }
    }
    );
   }
  )

import "controllers"
import "bootstrap"

import { initSortable } from "./init_sortable"
initSortable()
