# encoding: UTF-8
require 'spec_helper'

describe Post do
  def make_post_and_publish!(publish = true)
    @post = Post.make! :published => publish
    @save_time = @post.created_at
    @published_time = @post.published_at
  end

  describe "#published_at" do
    context "unpublished" do
      it "should be nil" do
        make_post_and_publish! false
        @post.published_at.should == nil
      end
    end

    context "published" do
      it "should be set" do
        make_post_and_publish!
        @post.published_at.should <= @post.updated_at
      end
    end

    context "unpublished -> published" do
      it "should be set" do
        make_post_and_publish! false
        @post.published = true
        @post.save!
        @post.published_at.should <= @post.updated_at
      end
    end

    context "unpublished -> unpublished" do
      it "should be nil" do
        make_post_and_publish! false
        @post.body_markdown = 'Still draft'
        @post.save!
        @post.published_at.should == nil
      end
    end

    context "published -> published" do
      it "shouldn't be updated" do
        make_post_and_publish!
        @post.body_markdown = 'Still published'
        @post.save!
        @post.published_at.should == @published_time
      end
    end

    context "published -> unpublished" do
      it "should be nil" do
        make_post_and_publish!
        @post.published = false
        @post.save!
        @post.published_at.should == nil
      end
    end
  end

  describe "should automatically generate permalink from title when it" do
    before :all do
      @post = Post.make!(:title => 'Permalink тест')
    end
    it "is created" do
      @post.permalink.should == 'permalink-test'
    end
    it "is updated" do
      @post.title = 'Changed title тест'
      @post.save!
      @post.permalink.should == 'changed-title-test'
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
