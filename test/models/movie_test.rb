require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  test 'migrate' do
    columns = Movie.columns.map &:name
    assert_includes columns, 'id'
    assert_includes columns, 'count'
    assert_includes columns, 'lat'
    assert_includes columns, 'long'
    assert_includes columns, 'uuid'
    assert_includes columns, 'user_id'
  end
end
