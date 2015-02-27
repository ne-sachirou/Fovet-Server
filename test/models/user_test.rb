require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'migrate' do
    columns = User.columns.map &:name
    assert_includes columns, 'id'
    assert_includes columns, 'password_hash'
    assert_includes columns, 'created_at'
    assert_includes columns, 'updated_at'
  end
end
