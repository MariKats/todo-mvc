class SessionsController < ApplicationController
  def new

  end

  def create
    auth = request.env["omniauth.auth"]
    if auth
      sign_in_with_auth(auth)
    else
      sign_in_with_password
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
