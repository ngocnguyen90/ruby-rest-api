require 'rails_helper'

RSpec.describe BlacklistedToken, type: :model do
  describe 'BlacklistedToken' do
    before {create(:user)}
    subject(:blacklisted_token) { build(:blacklisted_token) }
    it { is_expected.to be_valid }
  end
end
