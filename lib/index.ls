convert = (geojson, date, id, param) ->
  # console.log JSON.stringify geojson,null,'  '
#   console.log geojson
  list = geojson?features.map( -> [
    it.properties?[id]
    it.properties?[date]
    it.geometry?coordinates.0
    it.geometry?coordinates.1
    it.properties?[param]
  ]).filter( ->
    it.2 && it.3
  ).reduce((a,b) ->
    console.log b
    if (a.some -> it.id === b.0)
      # This id is present so push to location array
      a.find (v,i) ->
        console.log i
    else
      # This id is not present so create skeleton
      a.push do
        id: b.0
        position: cartographicDegrees: [ b.1, b.2, b.3, b.4 ]
    a
  ,[])

  console.log list


module.exports = {
  convert
}