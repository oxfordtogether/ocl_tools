import { Controller } from "stimulus";
import Color from 'color'
import { Chart, BarController, LineController, PieController, ArcElement, BarElement, LineElement, PointElement, CategoryScale, LinearScale, TimeScale, Legend } from "chart.js"
import ChartDataLabels from 'chartjs-plugin-datalabels'
import 'chartjs-adapter-date-fns'

Chart.register(BarController, LineController, PieController, ArcElement, BarElement, LineElement, PointElement, CategoryScale, LinearScale, TimeScale, Legend, ChartDataLabels);


/**
 * @abstract
 */
export default class ChartController extends Controller {
    static targets = ['chart'];

    jsonConfigFields = ['data', 'colors', 'explode'];

    config = {
        data: [],
        title: '',
        squashable: true,
        dataType: 'count',
        period: 'day',
        labelSize: 'auto',
        showLegend: false,
        showYScale: false,
        colors: {
            blue: '#3B82F6',
            red: '#EF4444',
            green: '#10B981',
            purple: '#8B5CF6',
            yellow: '#F59E0B',
            pink: '#EC4899',
            gray: '#6B7280',
            indigo: '#6366F1',
        },
    };

    connect() {
        // Merge in extra config settings
        Object.assign(this.config, this.getExtraConfigOptions());

        // Mutate the config
        for (const key in this.config) {
            const isJsonableField = this.jsonConfigFields.includes(key);
            let value;

            if (this.data.has(key)) {
                value = this.data.get(key);

                // If it's json, decode it
                if (isJsonableField) {
                    try {
                        value = JSON.parse(value);
                    } catch (e) { }
                }
            }

            if (typeof this.config[key] === 'object' && !Array.isArray(this.config[key]) && value !== 'undefined' && (typeof value !== 'object' || Array.isArray(value))) {
                // Config may reference a key (or values in the array) from the default config, use this key's value
                if (Array.isArray(value))
                    this.config[key] = value.map(v => this.config[key].hasOwnProperty(v) ? this.config[key][v] : v);
                else
                    this.config[key] = this.config[key].hasOwnProperty(value) ? this.config[key][value] : value;
            }
            else if (Array.isArray(this.config[key]) && !isJsonableField) {
                // Config is a value within an allowable list (if a list was valid, the field would be jsonable)
                if (value !== undefined && this.config[key].includes(value))
                    this.config[key] = value;
                else
                    this.config[key] = this.config[key][0] ? this.config[key][0] : undefined;
            }
            else if (value !== undefined) {
                // Use the given value as is
                this.config[key] = value;
            }
        }

        // Make sure colors are an array
        if (typeof (this.config.colors) === 'object' && !Array.isArray(this.config.colors))
            this.config.colors = Object.values(this.config.colors);
        if (!Array.isArray(this.config.colors)) {
            const count = Object.values(this.config.data).length;
            const color = this.config.colors;
            this.config.colors = [];
            for (let i = 0; i < count; i++)
                this.config.colors.push(Color(color).fade(i / count).string());
        }

        // Crude attempt at autosizing, should probably do something in a chart callback
        if (this.config.labelSize === 'auto') {
            this.config.labelSize = Math.min(32, 12 + 20 / Math.max(1, Object.values(this.config.data).length - 10));
        }
        console.log(this.getGraphSettings());
        // Create the chart
        new Chart(this.chartTarget, this.getGraphSettings());
    }

    getExtraConfigOptions() { }
}