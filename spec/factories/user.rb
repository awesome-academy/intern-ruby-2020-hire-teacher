FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.unique.email}
    password {Settings.password_default}
    password_confirmation {Settings.password_default}
    role {Faker::Number.between(Settings.one,Settings.role_final)}
    group {FactoryBot.create :group}
  end
end
