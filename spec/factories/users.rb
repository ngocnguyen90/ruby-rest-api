FactoryBot.define do
  factory :user do
    email { 'admin@gmail.com' }
    password { 'admin123' }
    admin { true }
  end

  trait :with_crypto do
    after(:create) do |user|
      create_list(:crypto_type, 2)
      create_list(:crypto, 4, user_id: user.id)
    end
  end
end
