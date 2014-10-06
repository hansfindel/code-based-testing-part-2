# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

t800  = CodeName.create(name: "T-800", info_reference: "http://en.wikipedia.org/wiki/Terminator_(character)", damage: 1)
t1000 = CodeName.create(name: "T-1000", info_reference: "http://en.wikipedia.org/wiki/T-1000", damage: 2)
tx    = CodeName.create(name: "T-X", info_reference: "http://en.wikipedia.org/wiki/T-X", damage: 5)


