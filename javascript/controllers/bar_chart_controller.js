import ChartController from './chart_controller'


export default class extends ChartController {
  getExtraConfigOptions() {
    return {
      label: 'label',
      dataType: 'value',
    };
  }


  getGraphSettings() {
    // X Axis configs based on period
    const yAxes = {
      count: {
        type: 'linear',
        beginAtZero: true,
        grace: '0',
        ticks: {
          stepSize: 1,
        },
        grid: {
          display: false,
        },
        afterFit: f => { if (this.config.labelSize) f.paddingTop = 16 + this.config.labelSize; return f; },
      },
      value: {
        type: 'linear',
        beginAtZero: true,
        grace: '0',
        grid: {
          display: false,
        },
        afterFit: f => { if (this.config.labelSize) f.paddingTop = 16 + this.config.labelSize; return f; },
      },
    }

    return {
      type: 'bar',
      data: {
        labels: this.config.data.map(row => row[this.config.label]),
        datasets: [{
          label: '',
          data: this.config.data,
          parsing: {
            xAxisKey: this.config.label,
            yAxisKey: this.config.dataType,
          },
          datalabels: {
            align: 'top',
            anchor: 'end',
            clamp: true,
            clip: false,
          }
        }]
      },
      options: {
        maintainAspectRatio: !this.config.squashable,
        plugins: {
          datalabels: {
            align: 'top',
            anchor: 'end',
            color: this.config.colors,
            font: {
              weight: 'bold',
              size: this.config.labelSize,
            },
            formatter: (v, c) => { return v[c.dataset.parsing.yAxisKey] ? v[c.dataset.parsing.yAxisKey] : '' },
          },
          legend: {
            display: this.config.showLegend,
          },
        },
        elements: {
          bar: {
            borderRadius: 4,
            backgroundColor: this.config.colors,
          },
        },
        title: {
          display: true,
          text: this.config.title,
        },
        legend: {
          display: false
        },
        scales: {
          x: Object.assign({}, {
            type: 'category',
            grid: {
              display: this.config.showYScale,
            },
          }),
          y: Object.assign(yAxes[this.config.dataType], {
            display: false,
          }),
        }
      }
    }
  };
}

