module Error
  class UnauthorizedError < CustomError
    def initialize
      super(401, 'Unauthorized')
    end
  end
end
