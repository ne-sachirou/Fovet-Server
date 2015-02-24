require 'test_helper'

class ThumbedupMovieTest < ActiveSupport::TestCase
  test 'migrate' do
    columns = ThumbedupMovie.columns.map &:name
    assert_includes columns, 'id'
    assert_includes columns, 'movie_id'
    assert_includes columns, 'user_id'
  end
end
