FactoryBot.define do
  factory :refresh_token do
    crypted_token { '1234xxxx' }
    user_id { 1 }
  end
end
