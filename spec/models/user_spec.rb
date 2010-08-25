require 'spec_helper'

describe User do
  pass = 'qwerty'
  salt = 'b1b3773a05c0ed0176787a4f1574ff0075f7521e'
  hash = 'b1b3773a05c0ed0176787a4f1574ff0075f7521e'
  salted = '4b31b6cd19aaf2dad022d312179ad637cef9138a'
  
  before :each do
    @user = User.new(:password => pass)
  end
  
  it "should encrypt string properly" do
    User.encrypt(pass).should == hash
  end
  
  it "should encrypt string with salt properly" do
    User.encrypt(pass, salt).should == salted
  end
  
  it "should create salt and proper hash when setting password" do
    @user.password_hash.should_not be_nil
    @user.password_salt.should_not be_nil
    @user.password_hash.should == User.encrypt(pass, @user.password_salt)
  end
  
  it "should confirm valid password" do
    @user.password?(pass).should == true
  end
  
  it "should reject invalid password and add an error" do
    @user.password?(pass.to_s + 'a').should == false
    @user.errors.should have_key(:password)
  end
  
  it "should be saved with all fields" do
    @user.save.should == true
  end
  
  it "should not be saved without any fields" do
    user = User.new
    user.save.should == false
  end
  
  it "should not be saved without hash" do
    user = User.new(:password_hash => salted)
    user.save.should == false
  end
  
  it "should not be saved without salt" do
    user = User.new(:password_salt => salt)
    user.save.should == false
  end
end
