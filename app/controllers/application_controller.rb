class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def authentication_required
    redirect_to login_path if !logged_id?
  end

  def logged_id?
    !!current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]).email if session[:user_id]
  end
end
