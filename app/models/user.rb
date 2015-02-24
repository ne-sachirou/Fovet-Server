class User < ActiveRecord::Base
  include BCrypt
  has_many :movies, dependent: :destroy
  has_many :thumbedup_movies, dependent: :destroy

  def password
    @password ||= Password.new password_hash
  end

  def password= raw_password
    @password = Password.create raw_password
    self.password_hash = @password
  end
end
