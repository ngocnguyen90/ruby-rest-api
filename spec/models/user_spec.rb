require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validates' do
    subject(:user) { build(:user) }
    it { is_expected.to be_valid }

    context 'when email is blank' do
      before { user.email = nil }

      it { is_expected.to be_invalid }
    end

    context 'when password is blank' do
      before { user.password = nil }

      it { is_expected.to be_invalid }
    end

    context 'when password and password_confirmation does not match' do
      before do
        user.password = '123456'
        user.password_confirmation = '1234567'
      end

      it { is_expected.to be_invalid }
    end

    context 'when email already exists' do
      before do
        create(:user)
        user.email = 'admin@gmail.com'
      end

      it { is_expected.to be_invalid }
    end
  end
end
