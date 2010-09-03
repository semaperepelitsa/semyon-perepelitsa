class PostsController < ApplicationController
  before_filter :authorize, :except => [:index, :show]
  before_filter :set_publish_field, :only => [:create, :update]
  caches_page :index, :show
  cache_sweeper :post_sweeper, :only => [:create, :update, :destroy]

  def index
    @posts = Post.published.recent
  end

  def show
    @post = Post.published_unless(admin?).find(params[:id])
    if params[:id].to_s != @post.to_param
      headers["Status"] = "301 Moved Permanently"
      redirect_to @post
    end
  end

  def drafts
    @posts = Post.unpublished.last_updated
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(params[:post])

    if @post.save
      redirect_to(@post.published? ? posts_path : unpublished_posts_path, :notice => 'Post was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(params[:post])
      redirect_to(@post, :notice => 'Post was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to(posts_url)
  end

  private

  def set_publish_field
    params[:post][:published] = !params[:publish].nil?
  end
end
