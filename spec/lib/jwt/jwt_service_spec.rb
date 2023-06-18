require 'rails_helper'
require './lib/jwt/jwt_service'

RSpec.describe Jwt::JwtService do
  before :all do
    @user = create(:user, :with_token)
  end
  describe 'JwtService' do
    context 'encode' do
      it 'encode payload correctly' do
        access_token, jti, exp = Jwt::JwtService.encode(@user)

        expect(access_token).to be_truthy
        expect(jti).to be_truthy
        expect(exp).to be_truthy
      end
    end
    context 'decode' do
      it 'decode token correctly' do
        access_token, _jti, _exp = Jwt::JwtService.encode(@user)
        user_infor = Jwt::JwtService.decode(access_token)
        expect(user_infor).to include(:user_id, :jti, :iat, :exp, :email)
        expect(user_infor[:user_id]).to eq @user.id
      end

      it 'return nil on invalid token' do
        invalid_token = 'hello.abc'
        expect(Jwt::JwtService.decode(invalid_token)).to eq nil
      end
    end
  end
end
