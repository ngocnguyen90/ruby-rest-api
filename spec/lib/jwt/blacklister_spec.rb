require 'rails_helper'
require './lib/jwt/blacklister'

RSpec.describe Jwt::Blacklister do
  before :all do
    @user = create(:user)
  end
  describe 'Blacklister' do
    it 'create blacklist token successfully' do
      result = Jwt::Blacklister.blacklist!(jti: '123456', exp: 123_456, user: @user)

      expect(result).to be_truthy
      expect(BlacklistedToken.find_by(jti: '123456')).to be_truthy
    end

    it 'blacklisted? works correctly' do
      result = Jwt::Blacklister.blacklisted?(jti: '123456')

      expect(result).to be_falsy
    end
  end
end
