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
    assert_includes columns, 'created_at'
    assert_includes columns, 'updated_at'
  end

  test 'Movies count is 0 should be destroyed.' do
    movie = Movie.create count: 1, lat: 1.5, long: 1.5, uuid: '66a92d96-a86a-452c-8df2-fb181147a52e', user_id: 1
    movie.thumbup
    assert_equal 0, movie.count
    assert movie.destroyed?
    Movie.destroy_all
  end

  test 'Get nearby movies.' do
    assert_includes Movie.nearby(1.4, 1.4), movies(:one)
    assert_includes Movie.nearby(1.6, 1.6), movies(:one)
    assert_not_includes Movie.nearby(1.3, 1.3), movies(:one)
    assert_not_includes Movie.nearby(1.7, 1.7), movies(:one)
  end
end
