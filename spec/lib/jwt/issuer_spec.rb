require 'rails_helper'
require './lib/jwt/issuer'

RSpec.describe Jwt::Issuer do
  before :all do
    @user = create(:user)
  end
  describe 'Issuer' do
    it 'issued a token successfully' do
      access_token, refresh_token, exp = Jwt::Issuer.call(@user).result

      expect(access_token).to be_truthy
      expect(refresh_token).to be_truthy
      expect(exp).to be_truthy
    end
  end
end
