require 'rails_helper'

RSpec.describe RefreshToken, type: :model do
  describe 'RefreshToken' do
    before {create(:user)}
    subject(:refresh_token) { build(:refresh_token) }
    it { is_expected.to be_valid }
  end
end
