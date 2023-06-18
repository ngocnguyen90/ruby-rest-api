module TokenAuthenticatable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request

    attr_reader :current_user
  end

  private

  def authenticate_request
    result = Authentication::AuthorizeApiRequest.call(
      request.headers,
      params[:access_token]
    )&.result
    raise(Error::UnauthorizedError) unless result.present?

    @current_user = result
  end
end
