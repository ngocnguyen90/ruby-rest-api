require 'rails_helper'

RSpec.describe WhitelistedToken, type: :model do
  describe 'WhitelistedToken' do
    before { create(:user) }
    subject(:whitelisted_token) { build(:whitelisted_token) }
    it { is_expected.to be_valid }
  end
end
