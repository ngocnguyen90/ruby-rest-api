require 'rails_helper'

RSpec.describe 'Api::V1::Cryptos', type: :request do
  before :all do
    @user = create(:user, :with_crypto)
    @crypto_type = create(:crypto_type)
  end

  describe 'GET /index' do
    it 'lists all cryptos' do
      login(@user)
      get '/api/v1/cryptos', as: :json

      expect(response).to have_http_status(200)
      expect(response_body).to include(:meta, :data)
      expect(response_body[:meta]).to include(:current_page, :next_page, :prev_page, :total_pages, :total_entries)
      expect(response_body[:data].size).to be 4
    end
  end

  describe 'GET /show' do
    context 'with valid crypto id' do
      it 'show a single crypto with id' do
        login(@user)
        get '/api/v1/cryptos/1', as: :json

        expect(response).to have_http_status(200)
        expect(response_body).to include(:id, :name, :crypto_type, :user, :created_at, :updated_at)
      end
    end

    context 'with invalid crypto id' do
      it 'show a single crypto with id' do
        login(@user)
        get '/api/v1/cryptos/9999', as: :json

        expect(response).to have_http_status(400)
        expect(response_body[:error]).to eq 'Not Found'
      end
    end
  end

  describe 'Post /create' do
    context 'with valid crypto params' do
      it 'creates a new crypto' do
        login(@user)
        params = {
          'name': 'EDU',
          'crypto_type_id': @crypto_type[:id],
          'user_id': @user.id,
          'price': 200
        }
        post '/api/v1/cryptos', params: params, as: :json

        expect(response).to have_http_status(200)
        expect(response_body[:message]).to eq 'Crypto was successfully created'
      end
    end

    context 'with invalid crypto params' do
      it 'return error if name is blank' do
        login(@user)
        params = {
          'name': nil,
          'crypto_type_id': @crypto_type[:id],
          'user_id': @user.id,
          'price': 200
        }
        post '/api/v1/cryptos', params: params, as: :json

        expect(response).to have_http_status(400)
        expect(response_body[:name]).to eq ["can't be blank"]
      end
    end
  end

  describe 'Post /create' do
    context 'with valid crypto params' do
      it 'creates a new crypto' do
        login(@user)
        params = {
          'name': 'EDU',
          'crypto_type_id': @crypto_type[:id],
          'user_id': @user.id,
          'price': 200
        }
        post '/api/v1/cryptos', params: params, as: :json

        expect(response).to have_http_status(200)
        expect(response_body[:message]).to eq 'Crypto was successfully created'
      end
    end

    context 'with invalid crypto params' do
      it 'return error if name is blank' do
        login(@user)
        params = {
          'name': nil,
          'crypto_type_id': @crypto_type[:id],
          'user_id': @user.id,
          'price': 200
        }
        post '/api/v1/cryptos', params: params, as: :json

        expect(response).to have_http_status(400)
        expect(response_body[:name]).to eq ["can't be blank"]
      end
    end
  end

  describe 'Post /update' do
    context 'with valid crypto params' do
      it 'creates a new crypto' do
        login(@user)
        params = {
          'name': 'PEPE',
          'crypto_type_id': @crypto_type[:id],
          'price': 4000
        }
        put '/api/v1/cryptos/1', params: params, as: :json

        expect(response).to have_http_status(200)
        expect(response_body[:message]).to eq 'Crypto was successfully updated'
      end
    end

    context 'with invalid crypto params' do
      it 'return error if name is blank' do
        login(@user)
        params = {
          'name': 'PEPE',
          'crypto_type_id': 9999,
          'price': nil
        }
        put '/api/v1/cryptos/1', params: params, as: :json

        expect(response).to have_http_status(400)
        expect(response_body[:crypto_type]).to eq ['must exist']
        expect(response_body[:price]).to eq ["can't be blank", 'is not a number']
      end

      it 'return error if crypto id does not blank' do
        login(@user)
        params = {
          'name': 'PEPE',
          'crypto_type_id': @crypto_type[:id],
          'price': 4000
        }
        put '/api/v1/cryptos/9999', params: params, as: :json

        expect(response).to have_http_status(400)
        expect(response_body[:error]).to eq 'Not Found'
      end
    end
  end
end
