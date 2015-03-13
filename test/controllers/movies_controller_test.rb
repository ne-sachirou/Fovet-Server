require 'test_helper'

class MoviesControllerTest < ActionController::TestCase
  include AssertJson
  setup do
    @movie = movies :one
    @movie.save_file File.new('test/fixtures/1.jpg', 'rb')
    @movie.user = users :one
    @movie.save
    @controller = MoviesController.new
  end

  test 'should get index' do
    token = login
    get :index, token: token
    assert_response :success
    assert_json @response.body do
      item 0 do
        has :count
        has :latitude
        has :longitude
        has :uuid
        has_not :id
        has_not :user_id
      end
    end
  end

  test 'should create movie' do
    token = login
    assert_difference 'Movie.count' do
      post :create, latitude: 1.5, longitude: 1.5, file: fixture_file_upload('1.jpg', 'image/jpeg'), token: token
    end
    assert_response :created
    assert_json @response.body do
      has :count
      has :latitude
      has :longitude
      has :uuid
      has_not :id
      has_not :user_id
    end
    Movie.destroy_all
  end

  test 'should show movie' do
    token = login
    get :show, id: @movie.uuid.to_param, token: token
    assert_response :success
    assert_json @response.body do
      has :count
      has :latitude
      has :longitude
      has :uuid
      has_not :id
      has_not :user_id
    end
  end

  test 'should destroy movie' do
    token = login
    assert_difference 'Movie.count', -1 do
      delete :destroy, id: @movie.uuid.to_param, token: token
    end
    assert_response :no_content
  end

  test 'Should get nearby movies.' do
    token = login
    get :nearby, latitude: 1.5, longitude: 1.5, token: token
    assert_response :success
    assert_json @response.body do
      item 0 do
        has :count
        has :latitude
        has :longitude
        has :uuid
        has_not :id
        has_not :user_id
      end
    end
  end

  test 'Should get movie file.' do
    token = login
    get :file, id: @movie.uuid.to_param, token: token
    assert_response :success
    assert_equal 'image/jpeg', @response.content_type
    assert_equal File.new('test/fixtures/1.jpg', 'rb').read, @response.body
  end

  test 'Should thumbup movie.' do
    token = login
    assert_difference '@movie.reload.count', -1 do
      post :thumbup, id: @movie.uuid.to_param, token: token
    end
    assert_response :ok
  end
end
