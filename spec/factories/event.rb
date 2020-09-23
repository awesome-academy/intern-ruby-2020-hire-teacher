FactoryBot.define do
  factory :event do
    title {Faker::Ancient.god}
    description {Faker::Lorem.sentence(Settings.one)}
    date_event {Faker::Date.between(Settings.rspec.start_date, Settings.rspec.end_date)}
    start_time {Settings.rspec.start_time}
    end_time {Settings.rspec.end_time}
    color {Faker::Number.between(Settings.one,Settings.color_final)}
    deleted_at {nil}
    room {FactoryBot.create :room}
    user {FactoryBot.create :user}
  end
end
