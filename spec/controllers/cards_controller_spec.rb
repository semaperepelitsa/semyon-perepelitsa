require 'spec_helper'

describe CardsController do
  it "GET show page" do
    get :show
    response.should render_template(:show)
  end
end
