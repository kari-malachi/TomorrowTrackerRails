class UsersController < ApplicationController
  def new
    # Registration page for new users
    not_logged_in_checker { @user = User.new }
  end

  def create
    # Registration attempt for new users
    not_logged_in_checker {
      @user = User.new(user_params)
      if @user.save
        redirect_to login_session_url
      else
        render 'new'
      end
    }
  end

  def make_admin
    # Upgrades a user to an admin. Does not affect stack affiliation
    logged_in_checker {
      called_by_admin {
        @user = User.find(params[:id])
        @user.update(type: 'Admin')
        redirect_to show_user_url
      }
    }
  end

  def revoke_admin
    # Removes admin privileges from the user. Returns them to stacker
    logged_in_checker {
      called_by_admin {
        @user = User.find(params[:id])
        @user.update(type: 'Stacker')
        redirect_to show_user_url
      }
    }
  end

  def show
    # User's Home
    logged_in_checker {
      @user = User.find(params[:id])
      if !@user.is_user?(current_user)
        # This page can only be shown to its owner or an admin
        called_by_admin {}
      end
      if @user.stack_id
        @stack = Stack.find(@user.stack_id)
      end
    }
  end

  def index
    logged_in_checker {
      called_by_admin {
        @users = User.all
      }
    }
  end

  def destroy
    logged_in_checker {
      called_by_admin {
        @user = User.find(params[:id])
        @user.destroy
        redirect_to users_url
      }
    }
  end

  private
    def user_params
      params.require(:user).permit(:name, :username, :password, :password_confirmation, :type)
    end
end
