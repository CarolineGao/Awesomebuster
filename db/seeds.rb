# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Tester.create!(name: "Example Tester",
               email: "tester@tester.com",
               password:              "demoadmin",
               password_confirmation: "demoadmin",
               admin: true)

99.times do |n|
  name = Faker::Name.name
  email = "tester-#{n+1}@tester.com"
  password = "password"
  Tester.create!(name: name,
                 email: email,
                 password:              password,
                 password_confirmation: password)
end
