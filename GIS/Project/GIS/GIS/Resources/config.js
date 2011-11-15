var appConfig = {
    'Services': {
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
            'mocMapService': [
      { 'url': 'http://localhost/ArcGIS/rest/services/Moc/MapServer', 'id': 'moctoadoMapService', 'label': 'Mốc toạ độ' },
      { 'url': 'http://localhost/ArcGIS/rest/services/MocDoCao/MapServer', 'id': 'mocdocaoMapService', 'label': 'Mốc Độ Cao' },
      { 'url': 'http://localhost/ArcGIS/rest/services/MocTrongLuc/MapServer', 'id': 'moctronglucMapService', 'label': 'Mốc Trọng lực' }
      ]
        }
    };