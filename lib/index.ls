convert = (geojson, options) ->
  {date,id,elev,label} = options

  # Store all labels for each feature
  labels = geojson.features.reduce((a,b) ->
    p = b.properties
    a[p[id]] = p[label] || ''
    a
  ,{})


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

  /*
    Before we separate records into their
    lines grab the first and last records
  */
  first = sorted.0
  last = sorted[sorted.length - 1]

  /*
    Reduce points into their lines
  */
  list = sorted.reduce((a,b) ->
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

  /*
    Add feature level CZML options
  */
  list.forEach ->
    it.path = do
      material:
        polylineOutline:
          color: rgba: [86,0,255,255]
          outlineColor: rgba: [0,0,0,100]
          outlineWidth: 5
      width: 8
      leadTime: 10
      trailTime: 1000000
      resolution: 5

    start = it.position.cartographicDegrees.0
    end = it.position.cartographicDegrees[
      it.position.cartographicDegrees.length - 4
    ]

    it.availability = "#start/#end"

    it.billboard = do
      image: 'data:image/png;base64,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'
      scale: 0.25
      pixelOffset: cartesian2: [0,-10]

    it.label = do
      style: 'fill'
      fillColor: rgba: [255,255,0,255]
      text: "#{labels[it.id]}"
      font: '18pt Arial bold'
      horizontalOrigin: 'left'
      pixelOffset: cartesian2: [0,-50]

  /*
    Add the header
  */
  list.unshift do
    id: \document
    name: 'Critter Paths'
    version: '1.0'
    clock:
      interval: "#{first.1}/#{last.1}"
      currentTime: "#{first.1}"
      multiplier: 1400

  list

module.exports = {
  convert
}
