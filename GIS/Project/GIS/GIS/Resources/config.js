var appConfig = {
    'service': {
        'baseMapService': {
            'url': 'http://localhost/ArcGIS/rest/services/bandonen/MapServer'
            //'url': 'http://localhost/ArcGIS/rest/services/BanDoNew/MapServer'
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
        'infoWindow': {
            'width': 200,
            'height': 200

        }
        ,
        // Bat tat nhung layer can thiet
        'layerServices':
      { 'url': 'http://localhost/ArcGIS/rest/services/Moc/MapServer',
          'id': 'moctoadoMapService',
          'label': 'Mốc',
          'enableLayers': [0, 1, 2]
      },
        // Danh sach layer
        'featureLayers':
       [{ 'url': 'http://localhost/ArcGIS/rest/services/Moc/MapServer/0',
           'title': 'Mốc trọng lực',
           'mode': 1,    // esri.layers.FeatureLayer.MODE_ONDEMAND
           'outFields': '*',
           'infoTemplate': { 'title': '${SoHieu}', 'content': '<b>Loại mốc: ${LoaiMoc:iLayerType}</b><br/>'
                                                   + '<b>Cấp hạng: ${CapHang:iLevel}</b><br/>'
                                                   + '<b>Tình trạng: ${TinhTrang:iState}</b><br/>'
                                                   + '<b>Năm thành lập: ${NamThanhLap}</b><br/>'
           },
           'symbol': {
               'type': 2,      // 1: Marker symbol , 2: picture marker symbol
               'geometryType': 'point',  // point,polyline,polygon,extent, multipoint 
               'url': '../../Content/images/icon/Circle_Blue16x16.png',
               'width': 16,
               'height': 16
           },
           'highlight': {
               'type': 2,      // 1: Marker symbol , 2: picture marker symbol
               'geometryType': 'point',  // point,polyline,polygon,extent, multipoint 
               'url': '../../Content/images/icon/Pin_Blue24x24.png',
               'width': 24,
               'height': 24
            }
       },
        { 'url': 'http://localhost/ArcGIS/rest/services/Moc/MapServer/1',
            'title': 'Mốc toạ độ',
            'mode': 1,    // esri.layers.FeatureLayer.MODE_ONDEMAND 
            'outFields': '*',
            'infoTemplate': { 'title': '${SoHieu}', 'content': '<b>Loại mốc: ${LoaiMoc:iLayerType}</b><br/>'
                                                   + '<b>Cấp hạng: ${CapHang:iLevel}</b><br/>'
                                                   + '<b>Tình trạng: ${TinhTrang:iState}</b><br/>'
                                                   + '<b>Năm thành lập: ${NamThanhLap}</b><br/>'
            },
            'symbol': {
                'type': 2,      // 1: Marker symbol , 2: picture marker symbol
                'geometryType': 'point',  // point,polyline,polygon,extent, multipoint 
                'url': '../../Content/images/icon/Circle_Orange16x16.png',
                'width': 16,
                'height': 16
            },
            'highlight': {
                'type': 2,      // 1: Marker symbol , 2: picture marker symbol
                'geometryType': 'point',  // point,polyline,polygon,extent, multipoint 
                'url': '../../Content/images/icon/Pin_Orange24x24.png',
                'width': 24,
                'height': 24
            }
        }, { 'url': 'http://localhost/ArcGIS/rest/services/Moc/MapServer/2',
            'title': 'Mốc độ cao',
            'mode': 1,    // esri.layers.FeatureLayer.MODE_ONDEMAND
            'outFields': '*',
            'infoTemplate': { 'title': '${SoHieu}', 'content': '<b>Loại mốc: ${LoaiMoc:iLayerType}</b><br/>'
                                                   + '<b>Cấp hạng: ${CapHang:iLevel}</b><br/>'
                                                   + '<b>Tình trạng: ${TinhTrang:iState}</b><br/>'
                                                   + '<b>Năm thành lập: ${NamThanhLap}</b><br/>'
            },
            'symbol': {
                'type': 2,      // 1: Marker symbol , 2: picture marker symbol
                'geometryType': 'point',  // point,polyline,polygon,extent, multipoint 
                'url': '../../Content/images/icon/Circle_Red16x16.png',
                'width': 16,
                'height': 16
            },
            'highlight': {
                'type': 2,      // 1: Marker symbol , 2: picture marker symbol
                'geometryType': 'point',  // point,polyline,polygon,extent, multipoint 
                'url': '../../Content/images/icon/Pin_Red32x32.png',
                'width': 24,
                'height': 24
            }
        }
]

        }
    };

    /////////////////////////////////
    function iLevel(value) {
        switch (value) {
            case 1: return "Cấp I"; break;
            case 2: return "Cấp II"; break;
            case 3: return "Cấp III"; break;
        }
    }

    function iLayerType(value) {
        switch (value) {
            case 1: return "Mốc tọa độ"; break;
            case 2: return "Mốc độ cao"; break;
            case 3: return "Mốc trọng lực"; break;
        }
    }

    function iState(value) {
        switch (value) {
            case 1: return "Còn tốt"; break;
            case 2: return "Đang sửa chữa"; break;
            case 3: return "Không còn sử dụng"; break;
        }
    }