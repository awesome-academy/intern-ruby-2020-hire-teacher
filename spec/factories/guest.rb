FactoryBot.define do
  factory :guest do
    user {FactoryBot.create :user}
    event {FactoryBot.create :event}
  end
end
