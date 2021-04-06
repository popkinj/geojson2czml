require! {
  "../lib/index": \geo2czml
  # "./geo.json": \data # Test GeoJSON file
  "../../points.json": \data # My local GeoJSON file
}

options = do
  date: \date_recorded # The date property name
  param: \animal_status # The property of interest
  id: \critter_id # The unique id of the route


czml = geo2czml.convert data, options

console.dir czml, depth: 5
