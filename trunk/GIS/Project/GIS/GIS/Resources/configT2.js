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
          'enableLayers': [0,1]
      },
        'featureLayers':
       [{ 'url': 'http://localhost/ArcGIS/rest/services/Moc/MapServer/0',
          'title':'Mốc trọng lực',
          'mode': 1,    // esri.layers.FeatureLayer.MODE_ONDEMAND
          'outFields': '*',
          'infoTemplate': {'title': '${SoHieu}', 'content': '<b>Loại mốc: ${LoaiMoc:iLayerType}</b><br/>'
                                                   + '<b>Cấp hạng: ${CapHang:iLevel}</b><br/>'
                                                   + '<b>Tình trạng: ${TinhTrang:iState}</b><br/>'
                                                   + '<b>Năm thành lập: ${NamThanhLap}</b><br/>'}}]

    }
        { 'url': 'http://localhost/ArcGIS/rest/services/Moc/MapServer/1',
            'title': 'Mốc độ cao',
            'mode': 1,    // esri.layers.FeatureLayer.MODE_ONDEMAND 
            'outFields': '*',
            'infoTemplate': {'title': '${SoHieu}', 'content': '<b>Loại mốc: ${LoaiMoc:iLayerType}</b><br/>'
                                                   + '<b>Cấp hạng: ${CapHang:iLevel}</b><br/>'
                                                   + '<b>Tình trạng: ${TinhTrang:iState}</b><br/>'
                                                   + '<b>Năm thành lập: ${NamThanhLap}</b><br/>'}}]

    }

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