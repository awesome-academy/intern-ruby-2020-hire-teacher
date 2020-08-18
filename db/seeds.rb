# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Group.create!(name: "administration")

User.create!(name: "Manager",
             email: "manager@demo.com",
             password: "foobar",
             password_confirmation: "foobar",
             activated: true,
             group_id: 1,
             role: 1,
             activated_at: Time.zone.now)

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

5.times do
  Country.all.each{|country| country.locations.create!(name: Faker::Address.unique.city)}
end

User.create!(name: "Hoang Anh",
             email: "nguyen.@gmail.com",
             password: "hoanganh",
             password_confirmation: "hoanganh",
             activated: true,
             activated_at: Time.zone.now,
             group_id: 1,
             role: 1)

5.times do
  Location.all.each do |location|
    name = Faker::Address.state
    address = Faker::Address.street_address
    location.rooms.create!(
      name: name,
      address: address,
      user_id: 1)
  end
end
