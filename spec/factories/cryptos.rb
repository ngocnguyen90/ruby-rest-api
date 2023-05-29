FactoryBot.define do
  factory :crypto do
    name { Faker::Name.name }
    price { Faker::Number.positive }
    crypto_type_id { Faker::Number.between(from: 1, to: 2) }
    user_id { nil }
  end
end
