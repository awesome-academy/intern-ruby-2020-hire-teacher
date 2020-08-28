FactoryBot.define do
  factory :location do
    name {Faker::Address.city}
    country {FactoryBot.create :country}
  end
end
