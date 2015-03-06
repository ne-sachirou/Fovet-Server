class Movie < ActiveRecord::Base
  include ActiveUUID::UUID
  belongs_to :user
  before_save :destroy_exhausted
  after_destroy :destroy_file

  scope :nearby, -> latitude, longitude do
    latitude, longitude = latitude.to_f, longitude.to_f
    where(arel_table[:latitude].gteq latitude - 0.1).
      where(arel_table[:latitude].lteq latitude + 0.1).
      where(arel_table[:longitude].gteq longitude - 0.1).
      where(arel_table[:longitude].lteq longitude + 0.1)
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
