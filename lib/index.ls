convert = (geojson) ->
  console.log JSON.stringify geojson,null,'  '
#   console.log geojson
  list = geojson?features.map( -> [
    it.properties.critter_id
    it.properties?date_recorded
    it.geometry?coordinates.0
    it.geometry?coordinates.1
    it.properties?animal_status
  ]).filter( (.2 && .3) )
  console.log list


module.exports = {
  convert
}