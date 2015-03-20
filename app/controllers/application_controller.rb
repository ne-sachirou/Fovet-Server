class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :null_session

  rescue_from Forbidden do |ex|
    head :forbidden
  end

  rescue_from  ActiveRecord::RecordNotFound do |ex|
    head :not_found
  end
end
