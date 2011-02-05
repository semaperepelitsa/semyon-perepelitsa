class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :admin?

  protected

  # A filter method for administrator actions.
  def authorize
    unless admin?
      # Ensure the admin cookie is deleted
      admin! false

      # Preserve the current URL to redirect back after login
      redirect_to login_path(:then => request.fullpath)

      false
    end
  end

  # Returns true if the current user is an admin, false otherwise.
  def admin?
    !!session[:admin]
  end

  # Set up admin flag session and cookie variables.
  # Reset them if login is false.
  # The cookie is unsafe. It is used only in client-side javascript for non-critic operations.
  def admin!(login = true)
    if login
      session[:admin] = true
      cookies.permanent[:admin] = true
    else
      session[:admin] = nil
      cookies.delete(:admin)
    end
  end
end
