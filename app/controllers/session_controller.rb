class SessionController < ApplicationController
  def new
    create
  end
  
  def create
    session[:admin] ||= true
    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
