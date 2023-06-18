FactoryBot.define do
  factory :whitelisted_token do
    jti { '1234' }
    user_id { nil }
    exp { 12_345_678 }
  end
end
