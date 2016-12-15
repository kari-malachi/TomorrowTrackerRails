class UsersController < ApplicationController
  def new
    not_logged_in_checker { @user = User.new }
  end

  def create
    not_logged_in_checker {
      @user = User.new(user_params)
      if @user.save
        redirect_to login_session_url
      else
        render 'new'
      end
    }
  end

  def show
    logged_in_checker {
      @user = User.find(params[:id])
    }
  end

  def index
    logged_in_checker {
      @users = User.all
    }
  end

  def destroy
    logged_in_checker {
      @user = User.find(params[:id])
      @user.destroy
      redirect_to users_url
    }
  end

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
        redirect_to users_url
      else
        yield
      end
    end

    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
end
