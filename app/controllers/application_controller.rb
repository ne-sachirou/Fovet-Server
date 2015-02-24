class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Forbidden do |ex|
    head :no_content, status: 403
  end

  def auth_token
    begin
      token = JWT.decode(params[:token], ENV['JWT_SECRET'])[0]
    rescue JWT::DecodeError
      raise Forbidden
    end
    if token[:expiration] < Time.now.to_i
      raise Forbidden
    end
    @user = User.find token[:user_id]
  end

  class Forbidden < Exception; end
end
