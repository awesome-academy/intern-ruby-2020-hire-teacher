FactoryBot.define do
  factory :report do
    comment {Faker::Lorem.sentence(Settings.one)}
    room {FactoryBot.create :room}
  end
end
