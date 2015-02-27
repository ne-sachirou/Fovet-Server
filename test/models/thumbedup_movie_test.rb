require 'test_helper'

class ThumbedupMovieTest < ActiveSupport::TestCase
  test 'migrate' do
    columns = ThumbedupMovie.columns.map &:name
    assert_includes columns, 'id'
    assert_includes columns, 'movie_id'
    assert_includes columns, 'user_id'
    assert_includes columns, 'created_at'
    assert_includes columns, 'updated_at'
  end
end
