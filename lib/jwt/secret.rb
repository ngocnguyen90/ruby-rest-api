module Jwt
  class Secret
    class << self
      def secret_token
        Rails.application.secrets.secret_key_base
      end
    end
  end
end
