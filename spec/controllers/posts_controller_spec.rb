require 'spec_helper'

describe PostsController do
  it "should get index page" do
    get :index
    response.should be_success
  end
  
end
