dojo.require("esri.layers.FeatureLayer");

var appConfig = {
    'service': {
        'baseMapService': {
            'url': 'http://localhost/ArcGIS/rest/services/final/MapServer'
        },
        'initialExtent': {
            "xmin": 5.327663718125301,
            "ymin": 10.708211035844892,
            "xmax": 5.51064426947365,
            "ymax": 10.827184086136407,
            "spatialReference": {
                "wkid": 4756
            }
        },
        'layerServices':
      { 'url': 'http://localhost/ArcGIS/rest/services/Moc/MapServer',
          'id': 'moctoadoMapService',
          'label': 'Mốc',
          'enableLayers': [0]
      },
        'featureLayers':
       [{ 'url': 'http://localhost/ArcGIS/rest/services/Moc/MapServer/0',
          'mode': 1,    // esri.layers.FeatureLayer.MODE_ONDEMAND 
          'outFields': '*',
          'infoTemplate': {'title':'Set title here','content': 'Set Content here'}}]

    }
};