module Jwt
  class RefreshToken
    prepend SimpleCommand

    attr_reader :refresh_token, :decoded_auth_token, :user

    def initialize(refresh_token, decoded_auth_token, user)
      @refresh_token = refresh_token
      @decoded_auth_token = decoded_auth_token
      @user = user
    end

    def call
      raise Error::MissingRefreshTokenError unless refresh_token.present? || decoded_auth_token.nil?

      existing_refresh_token = user.refresh_tokens.find_by_token(
        refresh_token
      )

      raise Error::InvalidTokenError unless existing_refresh_token.present?

      jti = decoded_auth_token.fetch(:jti)
      ActiveRecord::Base.transaction do
        new_access_token, new_refresh_token, exp = Jwt::Issuer.call(user)
        existing_refresh_token.destroy

        Jwt::Blacklister.blacklist!(jti: jti, exp: decoded_auth_token.fetch(:exp), user: user)
        Jwt::Whitelister.remove_white_list(jti: jti)
        [new_access_token, new_refresh_token, exp]
      end
    rescue ActiveRecord::RecordInvalid
      nil
    end
  end
end
