module Error
  class MissingRefreshTokenError < CustomError
    def initialize
      super(401, 'Missing Refesh Token!')
    end
  end
end
