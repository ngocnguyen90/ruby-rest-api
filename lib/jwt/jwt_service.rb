module Jwt
  class JwtService
    class << self
      def encode(user)
        jti = SecureRandom.hex
        exp = token_expiry
        access_token = JWT.encode({
                                    user_id: user.id,
                                    email: user.email,
                                    jti: jti,
                                    iat: token_issued_at.to_i,
                                    exp: exp
                                  }, Jwt::Secret.secret_token)
        [access_token, jti, exp]
      end

      def decode(token)
        body = JWT.decode(token, Jwt::Secret.secret_token, verify: true, verify_iat: true)[0]
        HashWithIndifferentAccess.new(body)
      rescue JWT::DecodeError, JWT::ExpiredSignature
        nil
      end

      def expiry
        TOKEN_EXPIRY_TIME.hours
      end

      def token_expiry
        (token_issued_at + expiry).to_i
      end

      def token_issued_at
        Time.now
      end
    end
  end
end
