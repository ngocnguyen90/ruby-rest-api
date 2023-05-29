module Authentication
  class AuthorizeApiRequest
    prepend SimpleCommand

    attr_reader :headers, :access_token

    def initialize(headers = {}, access_token = nil)
      @headers = headers
      @access_token = access_token
    end

    def call
      raise Error::MissingTokenError unless token.present?

      user
    end

    private

    def token
      access_token || http_auth_header
    end

    def user
      @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token && token_valid?
    end

    def token_valid?
      blacklisted = Jwt::Blacklister.blacklisted?(jti: decoded_auth_token[:jti])
      whitelisted = Jwt::Whitelister.whitelisted?(jti: decoded_auth_token[:jti])
      valid_issued_at = valid_issued_at?
      !blacklisted && whitelisted && valid_issued_at
    end

    def valid_issued_at?
      decoded_auth_token[:exp] >= Jwt::JwtService.token_issued_at.to_i
    end

    def decoded_auth_token
      @decoded_auth_token ||= Jwt::JwtService.decode(http_auth_header)
    end

    def http_auth_header
      headers['Authorization']&.split('Bearer ')&.last
    end
  end
end
