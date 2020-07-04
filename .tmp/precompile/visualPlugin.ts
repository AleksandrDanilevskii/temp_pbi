import { Visual } from "../../src/visual";
import powerbiVisualsApi from "powerbi-visuals-api"
import IVisualPlugin = powerbiVisualsApi.visuals.plugins.IVisualPlugin
import VisualConstructorOptions = powerbiVisualsApi.extensibility.visual.VisualConstructorOptions
var powerbiKey: any = "powerbi";
var powerbi: any = window[powerbiKey];

var exampleQualitybySeriesCC63AC1E21C2425F8F853453133FB7E6: IVisualPlugin = {
    name: 'exampleQualitybySeriesCC63AC1E21C2425F8F853453133FB7E6',
    displayName: 'Example_Quality_by_Series',
    class: 'Visual',
    apiVersion: '2.6.0',
    create: (options: VisualConstructorOptions) => {
        if (Visual) {
            return new Visual(options);
        }

        throw 'Visual instance not found';
    },
    custom: true
};

if (typeof powerbi !== "undefined") {
    powerbi.visuals = powerbi.visuals || {};
    powerbi.visuals.plugins = powerbi.visuals.plugins || {};
    powerbi.visuals.plugins["exampleQualitybySeriesCC63AC1E21C2425F8F853453133FB7E6"] = exampleQualitybySeriesCC63AC1E21C2425F8F853453133FB7E6;
}

export default exampleQualitybySeriesCC63AC1E21C2425F8F853453133FB7E6;