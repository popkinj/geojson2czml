require! {
  "../lib/index": \geo2czml
  # "./geo.json": \data # Test GeoJSON file
  "../../points.json": \data # My local GeoJSON file
}

options = do
  date: \date_recorded # The date property name
  id: \critter_id # The unique id of the route
  # elev: \animal_status # The property of interest


czml = geo2czml.convert data, options

console.dir czml, depth: 5
