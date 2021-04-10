require! {
  "../lib/index": \geo2czml
  "./geo.json": \data # Test GeoJSON file
  # "../../points.json": \data # My local GeoJSON file
}

options = do
  date: \date_recorded # The date property name
  id: \critter_id # The unique id
  label: \wlh_id # Optional label property
  # elev: \elevation # Optional elevation


czml = geo2czml.convert data, options

console.dir czml, {depth: 6, maxArrayLength: null}
