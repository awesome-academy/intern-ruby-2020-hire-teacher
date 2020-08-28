FactoryBot.define do
  factory :group do
    sequence(:name) { |n| Faker::Lorem.word + n.to_s }
  end
end
