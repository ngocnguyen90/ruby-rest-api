module Error
  class InvalidTokenError < CustomError
    def initialize
      super(401, 'Invalid Token!')
    end
  end
end
