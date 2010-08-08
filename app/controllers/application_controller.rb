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
end
