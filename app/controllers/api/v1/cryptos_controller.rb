class Api::V1::CryptosController < Api::V1Controller
  before_action :paginate_crypto_lists, only: [:index]

  def index
    render json: { meta: Pagination.call(@cryptos), data: @cryptos }, status: 200
  end

  def show
    @crypto = Crypto.find(params[:id])

    render json: @crypto, status: 200 unless @crypto.blank?
  end

  def create
    @crypto = Crypto.new(crypto_params)

    if @crypto.save
      render json: { message: 'Crypto was successfully created', data: @crypto }, status: 200
    else
      render json: @crypto.errors, status: 400
    end
  end

  def update
    @crypto = Crypto.find(params[:id])

    if @crypto.update(crypto_params)
      render json: { message: 'Crypto was successfully updated', data: @crypto }, status: 200
    else
      render json: @crypto.errors, status: 400
    end
  end

  def destroy
    @crypto = Crypto.find(params[:id])

    if @crypto.destroy
      render json: { message: 'Crypto was successfully deleted' }, status: 200
    else
      render json: @crypto.errors, status: 400
    end
  end

  def destroy_multiple
    @cryptos = Crypto.where(id: params[:ids])

    if @cryptos.delete_all.positive?
      render json: { message: 'Crypto Lists was successfully deleted' }, status: 200
    else
      render json: { error: 'Record not Found!' }, status: 400
    end
  end

  private

  def paginate_crypto_lists
    @cryptos = Crypto.search(cypto_paginate_params[:query]).order(created_at: :desc).paginate(
      page: cypto_paginate_params[:page] || DEFAULT_PAGE,
      per_page: cypto_paginate_params[:limit] || DEFAULT_LIMIT
    )
  end

  def crypto_params
    params.permit(:name, :crypto_type_id, :price).merge(user_id: current_user.id)
  end

  def cypto_paginate_params
    params.permit(:page, :limit, :query)
  end
end
