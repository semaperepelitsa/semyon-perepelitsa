class SessionController < ApplicationController
  layout 'posts'

  def new
    redirect_to posts_url if admin?
  end

  def create
    @user = User.first
    if @user.password?(params[:password])
      admin!
      redirect_to params[:then] || posts_url
    else
      render :new
    end
  end

  def destroy
    admin! false
    redirect_to posts_url
  end
end
