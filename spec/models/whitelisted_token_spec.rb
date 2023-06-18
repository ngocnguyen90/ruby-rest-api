require 'rails_helper'

RSpec.describe WhitelistedToken, type: :model do
  describe 'WhitelistedToken' do
    before { @user = create(:user) }
    subject(:whitelisted_token) { build(:whitelisted_token, user_id: @user.id) }
    it { is_expected.to be_valid }
  end
end
