FactoryBot.define do
  types = %w[POW DEFI]
  factory :crypto_type do
    name { types.sample }
  end
end
