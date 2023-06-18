FactoryBot.define do
  factory :refresh_token do
    crypted_token { '1234xxxx' }
    user_id { nil }
  end
end
