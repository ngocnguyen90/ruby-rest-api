module Error
  class MissingTokenError < CustomError
    def initialize
      super(401, 'Missing Token!')
    end
  end
end
