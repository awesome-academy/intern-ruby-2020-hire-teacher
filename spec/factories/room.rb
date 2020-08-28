FactoryBot.define do
  factory :room do
    name {Faker::Company.name}
    address {Faker::Address.full_address}
    location {FactoryBot.create :location}
    user {FactoryBot.create :user}
  end
end
