require 'spec_helper'

describe Post do
  def make_post_and_publish!(publish = true)
    @post = Post.make! :published => publish
    @time = @post.created_at
  end

  describe "should update created_at timestamp when it" do
    it "is being published" do
      make_post_and_publish! false
      @post.published = true
      @post.save!
      @post.created_at.should > @time
    end
  end
  
  describe "should not update created_at timestamp when it" do
    after :each do
      @post.save!
      @post.created_at.should == @time
    end
    
    it "is not being published" do
      make_post_and_publish! false
      @post.text = 'Still draft'
    end
  
    it "is still published" do
      make_post_and_publish!
      @post.text = 'Still published'
    end
  
    it "is being unpublished" do
      make_post_and_publish!
      @post.published = false
    end
  end
  
  describe "should automatically generate permalink from title when it" do
    before :all do
      @post = Post.make!(:title => 'Permalink test')
    end
    it "is created" do
      @post.permalink.should == 'permalink-test'
    end
    it "is updated" do
      @post.title = 'Changed title'
      @post.save!
      @post.permalink.should == 'changed-title'
    end
  end
  
  it "should keep permalink blank if there is no title" do
    post = Post.make!(:title => '')
    post.permalink.should be_blank
  end
  
  describe "should properly generate link when it" do
    it "has permalink" do
      post = Post.make! :title => 'Two words'
      post.to_param.should == post.id.to_s + '-' + post.permalink
    end
    it "has no permalink" do
      post = Post.make! :title => ''
      post.to_param.should == post.id.to_s
    end
  end
  
end
