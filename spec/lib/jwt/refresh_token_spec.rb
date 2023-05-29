require 'rails_helper'
require './lib/jwt/refresh_token'

RSpec.describe Jwt::RefreshToken do
  let(:refresh_token_double) do
    double('refresh_token')
  end

  let(:refresh_token) { '123456' }

  let(:decoded_auth_token) do
    {
      jti: 1234,
      exp: 123_456,
      user_id: 1
    }
  end

  before :all do
    @user = create(:user)
  end

  describe 'RefreshToken' do
    context 'with valid token and refresh token' do
      it 'refresh token successfully' do
        allow(@user).to receive_message_chain(:refresh_tokens, :find_by_token) { refresh_token_double }
        allow(@user).to receive_message_chain(:refresh_tokens, :create!) { '56789' }
        allow(refresh_token_double).to receive_message_chain(:destroy) { true }
        access_token, new_refresh_token, exp = Jwt::RefreshToken.call(refresh_token, decoded_auth_token,
                                                                      @user)&.result&.first()&.result

        expect(access_token).to be_truthy
        expect(new_refresh_token).to be_truthy
        expect(exp).to be_truthy
      end
    end

    context 'with invalid token and refresh token' do
      it 'return error if missing refresh token' do
        expect do
          Jwt::RefreshToken.call(nil, decoded_auth_token,
                                 @user)
        end.to(raise_error do |error|
          expect(error).to be_a(Error::MissingRefreshTokenError)
          expect(error.error).to eq 'Missing Refesh Token!'
        end)
      end

      it 'return error if missing access token' do
        expect do
          Jwt::RefreshToken.call(refresh_token, nil,
                                 @user)
        end.to(raise_error do |error|
          expect(error).to be_a(Error::InvalidTokenError)
          expect(error.error).to eq 'Invalid Token!'
        end)
      end
    end
  end
end
