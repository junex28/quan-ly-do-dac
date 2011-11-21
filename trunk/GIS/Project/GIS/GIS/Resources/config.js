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
          'enableLayers': [0, 1]
      },
        'featureLayers':
       [{ 'url': 'http://localhost/ArcGIS/rest/services/Moc/MapServer/0',
           'title': 'Mốc trọng lực',
           'mode': 1,    // esri.layers.FeatureLayer.MODE_ONDEMAND
           'outFields': '*',
           'infoTemplate': { 'title': 'Set title here', 'content': 'Set Content here' },
           'symbol': {'url':'../../Content/images/icon/Flag3RightBlue.png','width':16,'height':16}
       },
        { 'url': 'http://localhost/ArcGIS/rest/services/Moc/MapServer/1',
            'title': 'Mốc độ cao',
            'mode': 1,    // esri.layers.FeatureLayer.MODE_ONDEMAND 
            'outFields': '*',
            'infoTemplate': { 'title': 'Set title here', 'content': 'Set Content here'}}]

        }
    };