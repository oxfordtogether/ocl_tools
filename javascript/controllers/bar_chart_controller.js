import { Controller } from "stimulus";
import "chart.js"
import "chartjs-plugin-datalabels"

export default class extends Controller {
  static targets = ['chart'];

  connect() {
    const title = this.data.get("title")
    const maintainAspectRatio = !this.data.get("squashable");
    const data = JSON.parse(this.data.get('data'))
    new Chart(this.chartTarget, {
      type: 'bar',
      data: {
        labels: data.map( d => d.label ),
        datasets: [{
          label: '',
          data: data.map ( d => d.value ),
          backgroundColor: data.map ( d => d.background_color || 'rgb(169, 169, 169, 0.4)' ),
          borderColor: data.map ( d => d.border_color || 'rgb(169, 169, 169, 1.0)' ),
          borderWidth: 1,
          datalabels: {
            align: 'top',
            anchor: 'end'
          }
        }]
      },
      options: {
        maintainAspectRatio,
        plugins: {
          datalabels: {
            font: {
              weight: 'bold'
            },
          }
        },
        title: {
          display: true,
          text: title,
        },
        legend: {
          display: false
        },
        scales: {
          yAxes: [{
            ticks: {
              beginAtZero: true
            }
          }]
        }
      }
    });
  }
}
