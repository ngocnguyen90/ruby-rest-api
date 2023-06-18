FactoryBot.define do
  factory :user do
    email { 'admin@gmail.com' }
    password { 'admin123' }
    admin { true }
  end

  trait :with_crypto do
    after(:create) do |user|
      @crypto_type = create_list(:crypto_type, 2)
      create_list(:crypto, 4, crypto_type_id: @crypto_type[0][:id], user_id: user.id)
    end
  end

  trait :with_theme do
    after(:create) do |user|
      create(:theme, user_id: user.id)
    end
  end

  trait :with_token do
    after(:create) do |user|
      create(:blacklisted_token, user_id: user.id)
      create(:whitelisted_token, user_id: user.id)
    end
  end
end
