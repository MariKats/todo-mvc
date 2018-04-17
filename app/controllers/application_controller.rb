class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :logged_in?

  def authentication_required
    redirect_to root_path if !logged_in?
  end

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def sign_in_with_auth(auth)
    user = User.from_omniauth(auth)
    session[:user_id] = user.id
    redirect_to lists_path
  end

  def sign_in_with_password
    user = User.find_by(email: params[:email].downcase)
    if user == user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to lists_path
    else
      render :new
    end
  end
end
