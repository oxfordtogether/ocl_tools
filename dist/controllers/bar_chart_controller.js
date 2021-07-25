"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _chart_controller = _interopRequireDefault(require("./chart_controller"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

class _default extends _chart_controller.default {
  getExtraConfigOptions() {
    return {};
  }

  getGraphSettings() {
    return {
      type: 'bar',
      data: {
        labels: this.config.data.map(d => d.label),
        datasets: [{
          label: '',
          data: this.config.data.map(d => d.value),
          backgroundColor: this.config.data.map(d => d.background_color || 'rgb(169, 169, 169, 0.4)'),
          borderColor: this.config.data.map(d => d.border_color || 'rgb(169, 169, 169, 1.0)'),
          borderWidth: 1,
          datalabels: {
            align: 'top',
            anchor: 'end',
            clamp: true,
            clip: false
          }
        }]
      },
      options: {
        maintainAspectRatio: !this.config.squashable,
        plugins: {
          datalabels: {
            font: {
              weight: 'bold'
            }
          },
          legend: {
            display: this.config.showLegend
          }
        },
        title: {
          display: true,
          text: this.config.title
        },
        legend: {
          display: false
        },
        scales: {
          y: {
            ticks: {
              beginAtZero: true
            }
          }
        }
      }
    };
  }

}

exports.default = _default;