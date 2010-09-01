class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :admin?
  
  protected
  
  def authorize
    unless admin?
      redirect_to login_path
      false
    end
  end
  
  def admin?
    session[:admin]
  end
  
  def admin!(login = true)
    if login
      session[:admin] = true
      cookies.permanent[:admin] = true
    else
      reset_session
      cookies.delete(:admin)
    end
  end
end
