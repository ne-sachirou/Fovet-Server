module AuthToken
  extend ActiveSupport::Concern

  def auth_token
    begin
      token = JWT.decode(params[:token], ENV['JWT_SECRET'])[0]
    rescue JWT::DecodeError
      raise ApplicationController::Forbidden
    end
    raise ApplicationController::Forbidden if token['expiration'] < Time.now.to_i
    begin
      @user = User.find token['user_id']
    rescue ActiveRecord::RecordNotFound
      raise ApplicationController::Forbidden
    end
  end
end
