FactoryBot.define do
  factory :report do
    comment {Faker::Lorem.sentence(word_count: Settings.one)}
    user {FactoryBot.create :user}
    room {FactoryBot.create :room}
  end
end
