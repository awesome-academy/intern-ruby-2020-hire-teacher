FactoryBot.define do
  factory :event do
    title {Faker::Ancient.god}
    description {Faker::Lorem.sentence(word_count: Settings.one)}
    date_event {Faker::Date.between(from: Settings.rspec.start_date, to: Settings.rspec.end_date)}
    start_time {Settings.rspec.start_time}
    end_time {Settings.rspec.end_time}
    color {Faker::Number.between(from: Settings.one,to: Settings.color_final)}
    deleted_at {nil}
    room {FactoryBot.create :room}
    user {FactoryBot.create :user}
  end
end
