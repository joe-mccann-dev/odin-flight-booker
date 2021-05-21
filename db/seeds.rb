# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

san_francisco = Airport.create(code: 'SFO')
new_york = Airport.create(code: 'JFK')
boston = Airport.create(code: 'BOS')
atlanta = Airport.create(code: 'ATL')
chicago = Airport.create(code: 'ORD')
dallas = Airport.create(code: 'DFW')
seattle = Airport.create(code: 'SEA')