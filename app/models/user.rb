class User < ActiveRecord::Base
  validates_presence_of :password_hash, :password_salt
  
  def self.encrypt(password, salt = '')
    require 'digest/sha1'
    Digest::SHA1.hexdigest(password.to_s + salt)
  end
  
  def encrypt(password)
    new_password_salt! if self.password_salt.nil?
    self.class.encrypt(password, self.password_salt)
  end
  
  def password=(val)
    new_password_salt!
    self.password_hash = encrypt(val)
  end
  
  def password?(val)
    self.password_hash.nil? ? false : self.password_hash == encrypt(val)
  end
  
  def new_password_salt!
    self.password_salt = ActiveSupport::SecureRandom.hex(16)
  end
end
