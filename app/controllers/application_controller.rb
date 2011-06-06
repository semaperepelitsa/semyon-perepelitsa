class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :admin?, :guest?

  protected

  # A filter method for administrator actions.
  def authorize
    unless admin?
      # Preserve the current URL to redirect back after login
      redirect_to login_path(:then => request.fullpath)

      false
    end
  end

  # Returns true if the current user is an admin, false otherwise.
  def admin?
    !!session[:admin]
  end

  def guest?
    !admin?
  end

  # Set up admin flag session variable.
  # Reset it if login is false.
  def admin!(login = true)
    if login
      session[:admin] = true
    else
      session[:admin] = nil
    end
  end
end
