FactoryBot.define do
  factory :event do
    title {Faker::Ancient.god}
    description {Faker::Lorem.sentence(Settings.one)}
    date_event {Settings.rspec.date_event}
    start_time {Settings.rspec.start_time}
    end_time {Settings.rspec.start_end}
    color {Faker::Number.between(Settings.one,Settings.color_final)}
    room {FactoryBot.create :room}
    user {FactoryBot.create :user}
  end
end
