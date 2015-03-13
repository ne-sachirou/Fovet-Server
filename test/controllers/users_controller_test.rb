require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include AssertJson
  setup do
    @user = users :one
    @controller = UsersController.new
  end

  test 'should create user' do
    assert_difference 'User.count' do
      post :create, password: 'password'
    end
    assert_response :created
    assert_json @response.body do
      has :id
      has_not :password_hash
      has_not :password
    end
    user = User.find JSON.parse(@response.body)['id']
    assert user.password == 'password'
  end

  test 'should destroy user' do
    token = login
    assert_difference 'User.count', -1 do
      delete :destroy, id: @user, token: token
    end
    assert_response :no_content
  end

  test 'should login' do
    token = login
    assert_response :success
    assert_json @response.body do
      has :token
    end
    token = JWT.decode(token, ENV['JWT_SECRET'])[0]
    assert_equal @user.id, token['user_id']
    assert Time.now.to_i < token['expiration'] && token['expiration'] <= Time.now.to_i + 3600
  end

  # test "should update user" do
  #   patch :update, id: @user, user: {  }
  #   assert_redirected_to user_path(assigns(:user))
  # end
end
