class SessionsController < ApplicationController
  def new
    # Login page -- Home
    not_logged_in_checker {
      @user = User.new
    }
  end

  def create
    # Login attempt
    not_logged_in_checker {
      user = User.authenticate(params[:username], params[:password])
      if user
        session[:user_id] = user.id
        redirect_to show_user_url(user.id)
      else
        @user = User.new
        @user.errors.add(:base, "Invalid username or password")
        render 'new'
      end
    }
  end

  def destroy
    # Logout attempt
    logged_in_checker {
      session[:user_id] = nil
      redirect_to login_session_url
    }
  end
end
