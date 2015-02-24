require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include AssertJson
  setup do
    @user = users :one
    @controller = UsersController.new
  end

  # test "should get index" do
  #   get :index
  #   assert_response :success
  #   assert_not_nil assigns(:users)
  # end

  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end

  test 'should create user' do
    assert_difference 'User.count' do
      post :create, user: { password: 'password' }
    end
    assert_json @response.body do
      has :id
      has_not :password_hash
      has_not :password
    end
    user = User.find JSON.parse(@response.body)['id']
    assert user.password == 'password'
  end

  test 'should login' do
    post :login, id: @user.id, password: 'password'
    assert_json @response.body do
      has :token
    end
    token = JWT.decode(JSON.parse(@response.body)['token'], ENV['JWT_SECRET'])[0]
    assert_equal @user.id, token['user_id']
    assert Time.now.to_i < token['expiration'] && token['expiration'] <= Time.now.to_i + 3600
  end

  # test "should show user" do
  #   get :show, id: @user
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get :edit, id: @user
  #   assert_response :success
  # end

  # test "should update user" do
  #   patch :update, id: @user, user: {  }
  #   assert_redirected_to user_path(assigns(:user))
  # end

  # test "should destroy user" do
  #   assert_difference('User.count', -1) do
  #     delete :destroy, id: @user
  #   end

  #   assert_redirected_to users_path
  # end
end
