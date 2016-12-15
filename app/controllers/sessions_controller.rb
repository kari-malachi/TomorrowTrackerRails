class SessionsController < ApplicationController
  def new
    not_logged_in_checker {}
  end

  def create
    not_logged_in_checker {
      user = User.authenticate(params[:username], params[:password])
      if user
        session[:user_id] = user.id
        redirect_to show_user_url(user.id)
      else
        flash.now.alert = "Invalid username or password"
        render 'new'
      end
    }
  end

  def destroy
    logged_in_checker {
      session[:user_id] = nil
      redirect_to login_session_url
    }
  end
end
