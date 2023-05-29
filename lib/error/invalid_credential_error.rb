module Error
  class InvalidCredentialError < CustomError
    def initialize
      super(400, 'Invalid Credentials!')
    end
  end
end
