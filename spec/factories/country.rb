FactoryBot.define do
  factory :country do
    name {Faker::Address.state}
  end
end
