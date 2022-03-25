# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
case Rails.env
when "development"
  99.times do |index|
    Person.create!(name: "Person #{index}", cpf: "000.000.000-#{index}")
  end
end

p "Created #{Person.count} people in #{Rails.env}"
