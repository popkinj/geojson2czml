# GeoJSON2CZML
Convert [GeoJSON](https://geojson.org/) to [CZML](https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/CZML-Guide), Cesium Markup Language. This is the file format that [Cesium](https://cesium.com/platform/cesiumjs/) supports.
Only point feature types are currently supported.

Configure how attributes are stored in the GeoJSON. Specify the names of the date, id & parameter fields. These would be stored in the parameters object of the GeoJSON. The date and ID are mandatory. The _param_ field is an optional field you would want to report in Cesium.
```javascript
const options = {
  date: "date_recorded",
  param: "animal_status",
  id: "animal_id"
}
```

Here is a very simple example which shows the format of GeoJSON which has currently been tested to work.
```javascript
import geo2czml from 'geo2czml';

const geojson = 
{
  "type": "FeatureCollection",
  "features": [
    {
      "id": 1,
      "type": "Feature",
      "geometry": {
        "type": "Point",
        "coordinates": [
          122.00,
          43.00
        ]
      },
      "properties": {
        "sex": "Male",
        "wlh_id": "18-xxxxx",
        "species": "Flimmer Flammer",
        "location": null,
        "animal_id": "CAR217",
        "collar_id": "84cd57e9-a990-4e95-8971-dad0b5483126",
        "device_id": 81228,
        "frequency": 152.071,
        "critter_id": "80fb06b4-707e-4fd6-a03a-a2b07cf035b8",
        "animal_status": "Alive",
        "date_recorded": "2021-03-27T00:01:10-07:00",
        "device_status": "Mortality",
        "device_vendor": "Lotek",
        "population_unit": "Frisby-Boulder"
      }
    }
  ]
};

const czml = geo2czml.convert(geojson, option);
```

Running the main test.
```bash
npm test
```
