class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  private
    def logged_in_checker
      if current_user
        yield
      else
        redirect_to login_session_url
      end
    end
 
    def not_logged_in_checker
      if current_user
        redirect_to show_user_url(current_user)
      else
        yield
      end
    end

    def called_by_admin
      if current_user.admin?
        yield 
      else
        redirect_to show_user_url(current_user)
      end
    end

    def current_user_is_stacker
      if current_user.stacker?
        yield
      else
        redirect_to show_user_url(current_user)
      end
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
end
