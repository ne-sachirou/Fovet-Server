class UsersController < ApplicationController
  include AuthToken
  before_action :auth_token, only: [:destroy]

  # POST /users
  # POST /users.json
  def create
    @user = User.new user_params
    if @user.save
      render 'show.json', status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    head :no_content
  end

  def login
    begin
      @user = User.find params[:id]
    rescue ActiveRecord::RecordNotFound
      raise Forbidden
    end
    raise Forbidden unless @user.password == params[:password]
    token = {
      user_id:    @user.id,
      expiration: Time.now.to_i + 3600,
    }
    token = JWT.encode token, ENV['JWT_SECRET']
    render json: { token: token }
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    # params.require(:user).permit :password
    params.permit :password
  end
end
