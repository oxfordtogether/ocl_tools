"use strict";

require("core-js/modules/es.object.assign.js");

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _chart_controller = _interopRequireDefault(require("./chart_controller"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

class _default extends _chart_controller.default {
  getExtraConfigOptions() {
    return {
      type: ['bar', 'line'],
      period: ['day', 'week', 'month']
    };
  }

  getGraphSettings() {
    // X Axis configs based on period
    const xAxes = {
      day: {
        type: 'time',
        time: {
          displayFormats: {
            day: 'd'
          },
          unit: 'day'
        },
        grid: {
          display: false
        }
      },
      week: {
        type: 'time',
        time: {
          displayFormats: {
            week: 'wo'
          },
          unit: 'week'
        },
        grid: {
          display: false
        }
      },
      month: {
        type: 'time',
        time: {
          displayFormats: {
            month: 'LLLL'
          },
          unit: 'month'
        },
        ticks: {}
      }
    }; // Y Axis configs based on data type

    const yAxes = {
      count: {
        type: 'linear',
        beginAtZero: true,
        grace: '0',
        grid: {
          display: false
        },
        afterFit: f => {
          if (this.config.labelSize) f.paddingTop = 16 + this.config.labelSize;
          return f;
        }
      }
    }; // Return the chart settings

    return {
      type: this.config.type,
      data: {
        datasets: [{
          data: this.config.data,
          backgroundColor: this.config.color,
          parsing: {
            xAxisKey: this.config.period,
            yAxisKey: this.config.dataType
          }
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: !this.config.squashable,
        borderWidth: 0,
        plugins: {
          datalabels: {
            align: 'top',
            anchor: 'end',
            color: this.config.colors,
            font: {
              weight: 'bold',
              size: this.config.labelSize
            },
            formatter: (v, c) => {
              return v[c.dataset.parsing.yAxisKey] ? v[c.dataset.parsing.yAxisKey] : '';
            }
          },
          legend: {
            display: this.config.showLegend
          }
        },
        elements: {
          bar: {
            borderRadius: 4,
            backgroundColor: this.config.colors
          }
        },
        scales: {
          x: Object.assign(xAxes[this.config.period], {
            grid: {
              display: this.config.showYScale
            }
          }),
          y: Object.assign(yAxes[this.config.dataType], {
            display: false
          })
        }
      }
    };
  }

}

exports.default = _default;