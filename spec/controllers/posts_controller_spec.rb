require 'spec_helper'

describe PostsController do
  fixtures :posts

  shared_examples_for "both sides" do
    it "should display index page" do
      get :index
      response.should render_template(:index)
    end

    it "should display show page on each published post" do
      [Post.make!, Post.make!(:title => '')].each do |p|
        get :show, :id => p.to_param
        response.should render_template(:show)
        assigns[:post].should == p
      end
    end

    it "should redirect to proper post show page url" do
      p = Post.make!
      get :show, :id => p.id
      response.should redirect_to(p)
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
        posts.each do |p|
          get :edit, :id => p.to_param
          response.should redirect_to(login_url)
        end
      end
    end

    it "rejects POST post" do
      post :create, :post => Post.make.attributes
      response.should_not be_success
    end

    it "rejects PUT post" do
      posts.each do |p|
        p.text += " updated"
        put :update, :id => p.id, :post => p.attributes
        response.should_not be_success
      end
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

    it "should respond to GET drafts page" do
      get :drafts
      response.should render_template(:drafts)
    end

    it "should respond to GET new post page" do
      get :new
      response.should render_template(:new)
    end

    it "should respond to every GET edit post page" do
      posts.each do |p|
        get :edit, :id => p.to_param
        response.should render_template(:edit)
      end
    end

    it "should create post" do
      p = Post.make
      post :create, :post => p.attributes
      assigns[:post].text == p.text
    end

    it "should update valid post and redirect to it" do
      posts.each do |p|
        p.text += " updated"
        put :update, :id => p.id, :post => p.attributes
        response.should redirect_to(p)
        np = Post.find(p.id)
        np.text.should == p.text
      end
    end
  end
end
