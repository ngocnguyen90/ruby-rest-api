require 'rails_helper'

RSpec.describe Crypto, type: :model do
  describe 'validates' do
    before do
      create_list(:crypto_type, 2)
      @user = create(:user)
    end
    subject(:crypto) { build(:crypto, user_id: @user.id) }

    it { is_expected.to be_valid }

    context 'when name is blank' do
      before { crypto.name = nil }

      it { is_expected.to be_invalid }
    end
  end
end
