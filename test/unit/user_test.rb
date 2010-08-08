require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'hashing function' do
    assert_equal 'b1b3773a05c0ed0176787a4f1574ff0075f7521e', User.encrypt('qwerty')
  end
  
  test 'hashing function with salt' do
    assert_equal '4b31b6cd19aaf2dad022d312179ad637cef9138a', User.encrypt('qwerty', 'b1b3773a05c0ed0176787a4f1574ff0075f7521e')
  end
  
  test 'password hashing does something' do
    he = User.new
    he.password = 'qwerty'
    assert_not_nil he.password_hash
    assert_not_nil he.password_salt
  end
  
  test 'password comparison function' do
    he = User.new
    he.password = 'qwerty'
    assert he.password?('qwerty')
    assert !(he.password? 'qwertn')
  end
  
  test 'that password hash and salt are writable' do
    he = User.new
    hash = 'b1b3773a05c0ed0176787a4f1574ff0075f7521e'
    assert_nothing_raised { he.password_hash = hash }
    assert_equal hash, he.password_hash
    assert_nothing_raised { he.password_salt = hash }
    assert_equal hash, he.password_salt
  end
end
