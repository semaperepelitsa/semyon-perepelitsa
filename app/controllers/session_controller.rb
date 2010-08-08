class SessionController < ApplicationController
  def new
    redirect_to root_path if admin?
  end
  
  def create
    if User.first.password?(params[:password])
      session[:admin] = true
      redirect_to root_path
    else
      render :action => "new"
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
