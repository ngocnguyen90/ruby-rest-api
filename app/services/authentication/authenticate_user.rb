module Authentication
  class AuthenticateUser
    prepend SimpleCommand
    def initialize(email, password)
      @email = email
      @password = password
    end

    def call
      Jwt::Issuer.call(user) if user
    end

    def user
      user = User.find_by!(email: @email)
      return user if user&.authenticate(@password)

      errors.add(:Unauthorized, :failure)
      nil
    end
  end
end
