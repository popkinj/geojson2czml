require! {
  "../lib/index": \geojson
  "../../test-tracks.json": \data
}


console.log geojson.convert data