class SessionController < ApplicationController
  layout 'posts'

  def new
    redirect_to root_path if admin?
  end

  def create
    @user = User.first
    if @user.password?(params[:password])
      admin!
      redirect_to params[:then] || root_path
    else
      render :new
    end
  end

  def destroy
    admin! false
    redirect_to root_path
  end
end
