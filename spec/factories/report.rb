FactoryBot.define do
  factory :report do
    comment {Faker::Lorem.sentence(Settings.one)}
    user {FactoryBot.create :user}
    room {FactoryBot.create :room}
  end
end
