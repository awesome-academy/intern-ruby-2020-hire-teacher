Group.create!(name: "administration")

5.times do
  country = Faker::Address.country
  group = Faker::Ancient.unique.hero
  Group.create!(name: group)
  Country.create!(name: country)
end

User.create!(name: "Manager",
             email: "manager@demo.com",
             password: "#Manager123",
             password_confirmation: "#Manager123",
             activated: true,
             activated_at: Time.zone.now,
             group_id: Group.first.id,
             role: :manager)

User.create!(name: "Hoang Anh",
             email: "nguyen.@gmail.com",
             password: "@Manager123",
             password_confirmation: "@Manager123",
             activated: true,
             activated_at: Time.zone.now,
             group_id: Group.first.id,
             role: :manager)

10.times do
  name = Faker::Name.unique.name
  email = Faker::Internet.unique.email
  User.create!(name: name,
               email: email,
               password: "^Manager123",
               password_confirmation: "^Manager123",
               activated: true,
               activated_at: Time.zone.now,
               group_id: Group.ids.sample,
               role: Faker::Number.between(1, 4))
end

20.times do
  Location.create!(name: Faker::Address.unique.city,
                   country_id: Country.ids.sample)
end

100.times do
  name = Faker::Address.state
  address = Faker::Address.street_address
  Room.create!(name: name,
               address: address,
               location_id: Location.ids.sample,
               user_id: User.ids.sample)
end

5.times do |n|
  Report.create!(comment: Faker::Lorem.sentence(38),
                 user_id: User.ids.sample,
                 room_id: Room.ids.sample)
end

Room.all.each do |room|
  title = Faker::Company.industry
  description = Faker::Company.catch_phrase
  message = Faker::Company.catch_phrase
  user_id = User.ids.sample
  start_time = Faker::Time.between(DateTime.now, DateTime.now + 1, :morning)
  end_time = Faker::Time.between(DateTime.now, DateTime.now + 1, :morning)
  status = :activate
  if (User.find_by(id: user_id).trainee?)
    status = :inactivate
  end
  date_event = Faker::Date.forward(23)
  color = Faker::Number.between(1, 5)
  if start_time < end_time
    room.events.create!(
      title: title,
      description: description,
      message: message,
      user_id: user_id,
      start_time: start_time,
      end_time: end_time,
      status: status,
      date_event: date_event,
      color: color
    )
  end
end

Event.all.each do |event|
  5.times do |n|
    event.guests.create!(user_id: User.ids.sample)
  end
end
