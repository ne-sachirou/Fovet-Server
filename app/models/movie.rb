class Movie < ActiveRecord::Base
  belongs_to :user
  has_many :thumbedup_movies, dependent: :destroy
end
