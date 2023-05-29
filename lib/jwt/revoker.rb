module Jwt
  class Revoker
    prepend SimpleCommand

    attr_reader :user, :headers

    def initialize(user, headers)
      @headers = headers
      @user = user
    end

    def call
      jti = decoded_auth_token.fetch(:jti)
      exp = decoded_auth_token.fetch(:exp)

      Jwt::Whitelister.remove_white_list(jti: jti)
      Jwt::Blacklister.blacklist!(
        jti: jti,
        exp: exp,
        user: user
      )
    rescue StandardError
      raise Error::InvalidTokenError
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
