require 'spec_helper'

describe HomeController do
  it "GET index page" do
    get :index
    response.should render_template(:index)
  end
end
