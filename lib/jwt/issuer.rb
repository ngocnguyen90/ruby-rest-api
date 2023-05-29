module Jwt
  class Issuer
    prepend SimpleCommand
    def initialize(user)
      @user = user
    end

    def call
      access_token, jti, exp = Jwt::JwtService.encode(@user)
      refresh_token = @user.refresh_tokens.create!
      Jwt::Whitelister.whitelist!(
        jti: jti,
        exp: exp,
        user: @user
      )

      [access_token, refresh_token, exp]
    end
  end
end
