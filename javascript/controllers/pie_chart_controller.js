import ChartController from './chart_controller'


export default class extends ChartController {
    getExtraConfigOptions() {
        return {
            type: ['doughnut', 'pie'],
            showLegend: true,
        }
    }


    getGraphSettings() {
        return {
            type: this.config.type,
            data: {
                labels: Object.keys(this.config.data),
                datasets: [{
                    data: Object.values(this.config.data),
                }],
            },
            options: {
                responsive: true,
                maintainAspectRatio: !this.config.squashable,
                backgroundColor: this.config.colors,
                borderWidth: 2,
                plugins: {
                    datalabels: {
                        align: 'center',
                        anchor: 'middle',
                        color: '#fff',
                        font: {
                            weight: 'bold',
                            size: this.config.labelSize,
                        },
                    },
                    legend: {
                        display: this.config.showLegend,
                        position: 'right',
                    },
                },
            }
        };
    }
}