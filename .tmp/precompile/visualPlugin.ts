import { Visual } from "../../src/visual";
import powerbiVisualsApi from "powerbi-visuals-api"
import IVisualPlugin = powerbiVisualsApi.visuals.plugins.IVisualPlugin
import VisualConstructorOptions = powerbiVisualsApi.extensibility.visual.VisualConstructorOptions
var powerbiKey: any = "powerbi";
var powerbi: any = window[powerbiKey];

var qualitybySeries2B28A7A7F25E47BC907216217B70708F: IVisualPlugin = {
    name: 'qualitybySeries2B28A7A7F25E47BC907216217B70708F',
    displayName: 'QualitybySeries',
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
    powerbi.visuals.plugins["qualitybySeries2B28A7A7F25E47BC907216217B70708F"] = qualitybySeries2B28A7A7F25E47BC907216217B70708F;
}

export default qualitybySeries2B28A7A7F25E47BC907216217B70708F;