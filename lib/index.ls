convert = (geojson, options) ->
  {date,id,elev} = options

  # Pull required data from the geojson
  sorted = geojson?features.map( -> [
    it.properties?[id]
    it.properties?[date]
    it.geometry?coordinates.0
    it.geometry?coordinates.1
    it.properties?[elev] || 0
  ]).filter( -> # Must have coordinates
    it.2 && it.3
  ).sort((a,b) -> # Sort by date
    new Date(a.1) - new Date(b.1)
  )

  # Before we separate records into their
  # lines grab the first and last records
  first = sorted.0
  last = sorted[sorted.length - 1]

  list = sorted.reduce((a,b) -> # Reduce points into their lines
    if (index = a.findIndex -> it.id === b.0) > -1
      # This id is present so push to location array
      a[index].position.cartographicDegrees.push b.1, b.2, b.3, b.4
    else
      # This id is not present so create first entry
      a.push do
        id: b.0
        position: cartographicDegrees: [ b.1, b.2, b.3, b.4 ]
    a
  ,[])

  list.forEach ->
    it.path = do
      material:
        polylineOutline:
          color: rgba: [86,0,255,255]
          outlineColor: rgba: [0,0,0,100]
          outlineWidth: 5
      width: 8
      leadTime: 10
      trailTime: 10000
      resolution: 5

    start = it.position.cartographicDegrees.0
    end = it.position.cartographicDegrees[
      it.position.cartographicDegrees.length - 4
    ]

    it.availability = "#start/#end"

  # Add the header
  list.unshift do
    id: \document
    name: 'Critter Paths'
    version: '1.0'
    clock:
      interval: "#{first.1}/#{last.1}"
      currentTime: "#{first.1}"
      multiplier: 10000

  list

module.exports = {
  convert
}
