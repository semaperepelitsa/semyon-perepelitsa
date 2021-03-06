class PostsController < ApplicationController
  before_filter :authorize, :except => [:index, :show]
  before_filter :set_publish_field, :only => [:create, :update]
  layout 'posts'

  def index
    @posts = Post.published.recent
  end

  def show
    @post = Post.published_unless(admin?).find(params[:id])
    if params[:id].to_s != @post.to_param
      redirect_to @post, :status => :moved_permanently
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
      redirect_to(@post.published? ? posts_url : unpublished_posts_url)
    else
      render :action => "new"
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(params[:post])
      redirect_to(@post)
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
    params[:post][:published] = params[:publish].present?
  end
end
