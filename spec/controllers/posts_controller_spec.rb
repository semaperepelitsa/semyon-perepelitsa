require 'spec_helper'

describe PostsController do
  shared_examples_for "both sides" do
    it "GET index page" do
      get :index
      response.should render_template(:index)
    end

    it "GET show page for each published post" do
      [Post.make!, Post.make!(:title => '')].each do |pst|
        get :show, :id => pst.to_param
        response.should render_template(:show)
        assigns[:post].should == pst
      end
    end

    it "redirects to proper post show page url" do
      pst = Post.make!
      get :show, :id => pst.id
      response.should redirect_to(pst)
    end
  end

  describe "user side" do
    before :each do
      @controller.stubs(:admin?).returns(false)
    end

    it_should_behave_like "both sides"

    describe "redirects to login page on" do
      it "GET drafts page" do
        get :drafts
        response.should redirect_to(login_url(:then => unpublished_posts_path))
      end

      it "GET new post page" do
        get :new
        response.should redirect_to(login_url(:then => new_post_path))
      end

      it "GET edit post page" do
        pst = Post.make!
        get :edit, :id => pst.to_param
        response.should redirect_to(login_url(:then => edit_post_path(pst)))
      end
    end

    it "rejects POST post" do
      post :create, :post => Post.make.attributes
      response.should_not be_success
    end

    it "rejects PUT post" do
      pst = Post.make!
      pst.text += " updated"
      put :update, :id => pst.id, :post => pst.attributes
      response.should_not be_success
    end

    it "does not show unpublished posts" do
      lambda { get :show, :id => Post.make!(:published => false).to_param }.should raise_exception(ActiveRecord::RecordNotFound)
    end
  end

  describe "administrator side" do
    before :each do
      @controller.stubs(:admin?).returns(true)
    end

    it_should_behave_like "both sides"

    it "GET drafts page" do
      get :drafts
      response.should render_template(:drafts)
    end

    it "GET new post page" do
      get :new
      response.should render_template(:new)
    end

    it "GET edit post page" do
      pst = Post.make!
      get :edit, :id => pst.to_param
      response.should render_template(:edit)
    end

    it "POST post" do
      pst = Post.make
      post :create, :post => pst.attributes
      assigns[:post].text == pst.text
    end

    it "PUT post and redirect to it" do
      pst = Post.make!
      pst.text += " updated"
      put :update, :id => pst.id, :post => pst.attributes
      response.should redirect_to(pst)
      new_pst = Post.find(pst.id)
      new_pst.text.should == pst.text
    end

    it "creates published post by submit button" do
      pst = Post.make :published => nil
      post :create, :post => pst.attributes, :publish => 'Save published'
      assigns[:post].published?.should == true
    end

    it "creates unpublished post by submit button" do
      pst = Post.make :published => nil
      post :create, :post => pst.attributes, :commit => 'Save unpublished'
      assigns[:post].published?.should == false
    end
  end
end
