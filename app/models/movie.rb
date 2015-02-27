class Movie < ActiveRecord::Base
  include ActiveUUID::UUID
  belongs_to :user
  has_many :thumbedup_movies, dependent: :destroy
  before_save :destroy_exhausted

  scope :nearby, -> lat, long do
    where(arel_table[:lat].gteq lat - 0.1).
      where(arel_table[:lat].lteq lat + 0.1).
      where(arel_table[:long].gteq long - 0.1).
      where(arel_table[:long].lteq long + 0.1)
  end

  def thumbup
    self.count -= 1
    save
  end

  private

  def destroy_exhausted
    if count <= 0
      destroy
      false
    else
      true
    end
  end
end
