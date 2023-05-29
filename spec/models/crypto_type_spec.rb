require 'rails_helper'

RSpec.describe CryptoType, type: :model do
  describe 'CryptoType' do
    subject(:crypto_type) { build(:crypto_type) }
    it { is_expected.to be_valid }
  end
end
