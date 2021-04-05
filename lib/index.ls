convert = (geojson, date, id, param) ->
  # console.log JSON.stringify geojson,null,'  '
#   console.log geojson
  list = geojson?features.map( -> [
    it.properties?[id]
    it.properties?[date]
    it.geometry?coordinates.0
    it.geometry?coordinates.1
    it.properties?[param]
  ]).filter( -> # Must have coordinates
    it.2 && it.3
  ).reduce((a,b) ->
    if (index = a.findIndex -> it.id === b.0) > -1
      # This id is present so push to location array
      a[index].position.cartographicDegrees.push b.1, b.2, b.3, b.4
    else
      # This id is not present so create skeleton
      a.push do
        id: b.0
        position: cartographicDegrees: [ b.1, b.2, b.3, b.4 ]
    a
  ,[])

  console.dir list, depth:5


module.exports = {
  convert
}