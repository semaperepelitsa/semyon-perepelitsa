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
  
end
