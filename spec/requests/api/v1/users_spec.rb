require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  let(:valid_headers) do
    {}
  end

  before :all do
    @user = create(:user)
  end

  describe 'POST /api/v1/users/register' do
    context 'with valid attributes' do
      it 'create a new user' do
        post '/api/v1/users/register',
             params: { email: 'ngocnguyencmu@gmail.com', password: '123456', password_confirmation: '123456' },
             headers: valid_headers, as: :json

        expect(response).to have_http_status(200)
        expect(response_body[:message]).to eq 'User was successfully created'
        expect(User.find_by(email: 'ngocnguyencmu@gmail.com')).to be_truthy
      end
    end

    context 'with invalid attributes' do
      it 'does not create without email' do
        post '/api/v1/users/register',
             params: { password: '123456', password_confirmation: '123456' },
             headers: valid_headers, as: :json

        expect(response).to have_http_status(400)
        expect(response_body).to include(email: ["can't be blank"])
      end

      it 'does not create if password and password_confirm does not match' do
        post '/api/v1/users/register',
             params: { email: 'ngocnguyencmu@gmail.com', password: '123456', password_confirmation: '1234567' },
             headers: valid_headers, as: :json

        expect(response).to have_http_status(400)
        expect(response_body).to include(password_confirmation: ["doesn't match Password"])
      end

      it 'does not create duplicate user' do
        post '/api/v1/users/register',
             params: { email: @user.email, password: '123456', password_confirmation: '123456' },
             headers: valid_headers, as: :json

        expect(response).to have_http_status(400)
        expect(response_body).to include(email: ['has already been taken'])
      end
    end
  end

  describe 'POST /api/v1/users/login' do
    context 'with valid credentials' do
      it 'login a user successfully' do
        post '/api/v1/users/login',
             params: { email: 'admin@gmail.com', password: 'admin123' },
             headers: valid_headers, as: :json

        expect(response).to have_http_status(200)
        expect(response_body).to include(:access_token)
        expect(response_body).to include(:exp)
        expect(response_body).to include(:refresh_token)
        expect(response_body).to include(:user_id)
        expect(response_body).to include(:email)
      end
    end

    context 'with invalid credentials' do
      it 'return error if input wrong password' do
        post '/api/v1/users/login',
             params: { email: 'admin@gmail.com', password: '123456' },
             headers: valid_headers, as: :json

        expect(response).to have_http_status(400)
        expect(response_body[:error]).to eq 'Invalid Credentials!'
      end

      it 'return error if input wrong email' do
        post '/api/v1/users/login',
             params: { email: 'admin1@gmail.com', password: '123456' },
             headers: valid_headers, as: :json

        expect(response).to have_http_status(400)
        expect(response_body[:error]).to eq 'Not Found'
      end
    end
  end
end

describe 'Post /refresh' do
  before :all do
    @user = create(:user, :with_token)
    post '/api/v1/users/login',
         params: { email: 'admin@gmail.com', password: 'admin123' }, as: :json
    @login_infor = response_body
  end
  context 'with valid refresh_token' do
    it 'refresh token successfully' do
      post '/api/v1/users/refresh',
           params: { refresh_token: @login_infor[:refresh_token] },
           headers: { 'Authorization': "Bearer #{@login_infor[:access_token]}" }, as: :json
      expect(response).to have_http_status(200)
      expect(response_body).to include(:access_token)
      expect(response_body).to include(:exp)
      expect(response_body).to include(:refresh_token)
    end
  end

  context 'with invalid refresh_token' do
    it 'return error' do
      post '/api/v1/users/refresh',
           params: { refresh_token: 'invalid_token' },
           headers: { 'Authorization': "Bearer #{@login_infor[:access_token]}" }, as: :json
      expect(response).to have_http_status(401)
      expect(response_body[:error]).to eq 'Invalid Token!'
    end
  end
end
