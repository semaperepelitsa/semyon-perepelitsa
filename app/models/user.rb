class User < ActiveRecord::Base
  attr_reader :password # needed for handling password errors
  validates_presence_of :password_hash, :password_salt

  def self.encrypt(password, salt = '')
    require 'digest/sha1'
    Digest::SHA1.hexdigest(password.to_s + salt)
  end

  def encrypt(password)
    new_password_salt! if password_salt.nil?
    self.class.encrypt(password, password_salt)
  end

  def password=(val)
    new_password_salt!
    self.password_hash = encrypt(val)
  end

  def password?(val)
    valid = password_hash == encrypt(val)
    errors.add :password unless valid
    valid
  end

  def new_password_salt!
    self.password_salt = ActiveSupport::SecureRandom.hex(16)
  end
end
