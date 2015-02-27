class Movie < ActiveRecord::Base
  include ActiveUUID::UUID
  belongs_to :user
  has_many :thumbedup_movies, dependent: :destroy
  before_save :destroy_exhausted
  after_destroy :destroy_file

  scope :nearby, -> lat, long do
    lat, long = lat.to_f, long.to_f
    where(arel_table[:lat].gteq lat - 0.1).
      where(arel_table[:lat].lteq lat + 0.1).
      where(arel_table[:long].gteq long - 0.1).
      where(arel_table[:long].lteq long + 0.1)
  end

  def filename; "/tmp/#{uuid}"; end

  # @param [#read] file
  # @raise [Jpeg::Error] The file contents is not a JPEG.
  def save_file file
    File.open(filename, 'wb'){|f| f.write file.read }
    begin
      Jpeg.open filename
    rescue Jpeg::Error
      destroy_file
      raise
    end
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

  def destroy_file
    File.delete filename if File.exists? filename
  end
end
