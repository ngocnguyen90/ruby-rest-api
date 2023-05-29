module Authentication
  class RefreshTokenRequest
    prepend SimpleCommand

    attr_reader :current_user, :refresh_token, :headers

    def initialize(current_user, headers = {}, refresh_token = nil)
      @headers = headers
      @current_user = current_user
      @refresh_token = refresh_token
    end

    def call
      raise Error::MissingRefreshTokenError unless refresh_token.present?

      return unless current_user

      token_data = Jwt::RefreshToken.call(refresh_token, decoded_auth_token, current_user)
      token_data&.result
    end

    private

    def decoded_auth_token
      @decoded_auth_token ||= Jwt::JwtService.decode(http_auth_header)
    end

    def http_auth_header
      headers['Authorization']&.split('Bearer ')&.last
    end
  end
end
