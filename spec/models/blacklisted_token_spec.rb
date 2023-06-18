require 'rails_helper'

RSpec.describe BlacklistedToken, type: :model do
  describe 'BlacklistedToken' do
    before { @user = create(:user) }
    subject(:blacklisted_token) { build(:blacklisted_token, user_id: @user.id) }
    it { is_expected.to be_valid }
  end
end
