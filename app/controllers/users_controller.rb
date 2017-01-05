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

  def make_admin
    logged_in_checker {
      called_by_admin {
        @user = User.find(params[:id])
        @user.update(type: 'Admin')
        redirect_to show_user_url
      }
    }
  end

  def revoke_admin
    logged_in_checker {
      called_by_admin {
        @user = User.find(params[:id])
        @user.update(type: '')
        redirect_to show_user_url
      }
    }
  end

  def show
    logged_in_checker {
      @user = User.find(params[:id])
      if @user.id != current_user.id
        called_by_admin {}
      end
      if @user.type == 'Stacker' || @user.type == 'Stackee'
        @stack = Stack.find(@user.stack_id)
        @stackers = @stack.stackers
        @stackees = @stack.stackees
      end
      render 'show' + (@user.type || '')
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
