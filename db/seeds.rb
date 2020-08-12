# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do |n|
  name = Faker::Name.name
  Group.create!(name: name)
end

3.times do
  role = Faker::Job.unique.field
  Role.create!(name: role)
end

5.times do
  country = Faker::Address.country
  group = Faker::Ancient.hero
  Group.create!(name: group)
  Country.create!(name: country)
end

countries = Country.all

5.times do
  countries.each{|country| country.locations.create!(name: Faker::Address.unique.city)}
end

User.create!(name: "Hoang Anh",
             email: "nguyen.@gmail.com",
             password: "hoanganh",
             password_confirmation: "hoanganh",
             activated: true,
             activated_at: Time.zone.now,
             group_id: 1,
             role_id: 1)

locations = Location.all

5.times do
  locations.each do |location|
    name = Faker::Address.state
    address = Faker::Address.street_address
    location.rooms.create!(
      name: name,
      address: address,
      user_id: 1)
  end
end
