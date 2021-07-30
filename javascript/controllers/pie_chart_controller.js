import ChartController from './chart_controller'


export default class extends ChartController {
    getExtraConfigOptions() {
        return {
            type: ['doughnut', 'pie'],
            label: 'label',
            showLegend: true,
            explode: 0,
        }
    }


    getGraphSettings() {
        return {
            type: this.config.type, 
            data: {
                labels: this.config.data.map(row => row[this.config.label]),
                datasets: [{
                    data: this.config.data.map(row => row[this.config.dataType]),
                }],
            },
            options: {
                responsive: true,
                maintainAspectRatio: !this.config.squashable,
                backgroundColor: this.config.colors,
                borderWidth: 2,
                cutout: '33%',
                offset: Array.isArray(this.config.explode) ? this.config.data.map(row => (this.config.explode.includes(row[this.config.label]) ? 20 : 0)) : this.data.explode,
                plugins: {
                    datalabels: {
                        align: 'end',
                        anchor: 'center',
                        color: '#fff', //this.config.colors,
                        offset: Array.isArray(this.config.explode) ? this.config.data.map(row => (this.config.explode.includes(row[this.config.label]) ? 0 : -10)) : -10,
                        clamp: true,
                        // backgroundColor: this.config.colors,
                        // borderRadius: this.config.labelSize,
                        // padding: this.config.labelSize / 2,
                        font: {
                            family: 'Roboto,sans-serif',
                            weight: 'bold',
                            size: this.config.labelSize / 2,
                        },
                    },
                    legend: {
                        display: this.config.showLegend,
                        position: 'right',
                        labels: {
                            font: {
                                family: 'Roboto,sans-serif',
                                weight: 'bold',
                            },
                        }
                    },
                },
            }
        };
    }
}