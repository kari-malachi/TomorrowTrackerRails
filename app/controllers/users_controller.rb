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
      case @user.type
      when 'Stacker'
        @stackers = Stacker.find_all_in_stack(@user.stack_id)
        @stackees = Stackee.find_all_in_stack(@user.stack_id)
      end
      render 'show' + @user.type
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

    def called_by_admin
      if current_user.admin?
        yield 
      else
        redirect_to users_url
      end
    end

    def user_params
      params.require(:user).permit(:name, :username, :password, :password_confirmation, :type)
    end
end
