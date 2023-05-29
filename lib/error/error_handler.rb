module Error
  module ErrorHandler
    class << self
      def included(classIncluded)
        classIncluded.class_eval do
          rescue_from CustomError do |e|
            render json: { error: e.error }, status: e.status
          end
          rescue_from ActiveRecord::RecordNotFound, with: -> { render(json: { error: 'Not Found' }, status: 400) }
          rescue_from ActiveRecord::RecordInvalid, with: -> { render(json: { error: 'Bad Request' }, statsu: 400) }
        end
      end
    end
  end
end
