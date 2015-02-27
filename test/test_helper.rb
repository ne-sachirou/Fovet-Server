ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  # @param [User] user
  # @param [String] password
  # @return [String] JWT token.
  def login user = users(:one), password = 'password'
    bak = @controller
    @controller = UsersController.new
    post :login, id: user.id, password: password
    @controller = bak
    JSON.parse(@response.body)['token']
  end
end
