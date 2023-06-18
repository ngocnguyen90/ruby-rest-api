require 'rails_helper'

RSpec.describe 'Api::V1::Themes', type: :request do
  before :all do
    @user = create(:user, :with_theme)
  end

  describe 'GET /users/theme' do
    it 'show current user theme successfully' do
      login(@user)
      get '/api/v1/users/theme', as: :json

      expect(response).to have_http_status(200)
      expect(response_body).to include(:id, :header_color, :logo, :avatar)
    end
  end

  describe 'POST /users/theme' do
    context 'with invalid params' do
      it 'show current user theme successfully' do
        login(@user)
        params = {
          'header_color': nil,
          'logo': nil,
          'avatar': nil
        }
        post '/api/v1/users/theme/update', params: params, as: :json

        expect(response).to have_http_status(400)
        expect(response_body[:header_color]).to eq ["can't be blank"]
      end
    end

    context 'with valid params' do
      it 'show current user theme successfully' do
        login(@user)
        params = {
          'header_color': '#12490',
          'logo': nil,
          'avatar': nil
        }
        post '/api/v1/users/theme/update', params: params, as: :json

        expect(response).to have_http_status(200)
        expect(response_body[:message]).to eq 'Theme was successfully updated'
      end
    end
  end
end
