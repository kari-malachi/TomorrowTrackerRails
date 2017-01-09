class StacksController < ApplicationController
  def new
    logged_in_checker {
      current_user_is_stacker {
        @stack = Stack.new
      }
    }
  end

  def create
    logged_in_checker {
      current_user_is_stacker {
        @stack = Stack.new(stack_params)
        if @stack.save
          @current_user.update(type: 'Stacker', stack_id: @stack.id)
          redirect_to show_user_url(@current_user)
        else
          render 'new'
        end
      } 
    }
  end

  def edit
    logged_in_checker {
      @stack = Stack.find(params[:id])
      current_user_belongs_to_stack {}
    }
  end

  def update
    logged_in_checker {
      @stack = Stack.find(params[:id])
      current_user_belongs_to_stack {
        if @stack.update(stack_params)
          redirect_to show_stack_url(@stack)
        else
          render 'edit'
        end
      }
    }
  end

  def show
    logged_in_checker {
      @stack = Stack.find(params[:id])
      @user = current_user
      @stackers = @stack.stackers
      @stackees = @stack.stackees
    }
  end

  def join
    logged_in_checker {
      @stack = Stack.find(params[:id])
      current_user.update(stack_id: @stack.id)
      redirect_to show_user_url(@current_user)
    }
  end

  def leave
    logged_in_checker {
      @stack = Stack.find(params[:id])
      @user = current_user
      if @user.belongs_to_stack?(@stack.id)
        @user.update(stack_id: nil)
      end
      redirect_to show_user_url(@user)
    }
  end

  def index
    logged_in_checker {
      @stacks = Stack.all
      @user = current_user
    }
  end

  def destroy
    logged_in_checker {
      called_by_admin {
        @stack = Stack.find(params[:id])
        @stack.destroy
        redirect_to stacks_url
      }
    }
  end

  private
    def current_user_belongs_to_stack
      if current_user.admin? or current_user.belongs_to_stack?(@stack.id)
        yield
      else
        redirect_to show_user_url(current_user)
      end
    end

    def stack_params
      params.require(:stack).permit(:name, :description)
    end
end
