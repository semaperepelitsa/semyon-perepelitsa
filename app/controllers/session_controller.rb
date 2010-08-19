class SessionController < ApplicationController
  def new
    redirect_to root_path if admin?
  end
  
  def create
    @user = User.first
    if @user.password?(params[:password])
      session[:admin] = true
      cookies.permanent[:admin] = true
      redirect_to root_path
    else
      @user.errors[:password] = 'не верен'
      render :new
    end
  end

  def destroy
    reset_session
    cookies.delete(:admin)
    redirect_to root_path
  end
end
