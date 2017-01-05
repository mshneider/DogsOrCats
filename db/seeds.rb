# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

guesses_list = [
  [ 70, 150, "Dogs", true ],
  [ 72, 170, "Dogs", true ],
  [ 65, 120, "Cats", true ],
  [ 62, 100, "Cats", false ]
]

guesses_list.each do | height, weight, likes, confirmed |
  Guess.create( height: height, weight: weight, likes: likes, confirmed: confirmed )
end
