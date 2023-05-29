class Api::V1::CryptoTypesController < ApplicationController
  def index
    render json: { data: CryptoType.all }, status: 200
  end
end
