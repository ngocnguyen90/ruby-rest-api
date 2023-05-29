module Error
  class CustomError < StandardError
    attr_reader :status, :error

    def initialize(status, error)
      super()
      @status = status
      @error = error
    end
  end
end
