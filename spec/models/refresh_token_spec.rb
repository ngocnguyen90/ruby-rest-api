require 'rails_helper'

RSpec.describe RefreshToken, type: :model do
  describe 'RefreshToken' do
    before {@user = create(:user)}
    subject(:refresh_token) { build(:refresh_token, user_id: @user.id) }
    it { is_expected.to be_valid }
  end
end
