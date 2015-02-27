class User < ActiveRecord::Base
  include BCrypt
  has_many :movies, dependent: :destroy
  validate :password_is_not_empty

  def password
    @password ||= Password.new password_hash
  end

  def password= raw_password
    @password = Password.create raw_password
    self.password_hash = @password
  end

  private

  def password_is_not_empty
    errors.add :password, 'Password is empty.' if password == ''
  end
end
