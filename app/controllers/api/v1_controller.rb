class Api::V1Controller < ApplicationController
  include ActionController::Serialization
  include Error::ErrorHandler
  include TokenAuthenticatable
end
