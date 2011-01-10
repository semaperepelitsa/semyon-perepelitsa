class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :admin?

  protected

  def authorize
    unless admin?
      admin! false
      redirect_to login_path(:then => request.fullpath)
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
