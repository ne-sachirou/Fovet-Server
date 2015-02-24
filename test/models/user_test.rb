require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'migrate' do
    columns = User.columns.map &:name
    assert_includes columns, 'id'
    assert_includes columns, 'password_hash'
  end
end
