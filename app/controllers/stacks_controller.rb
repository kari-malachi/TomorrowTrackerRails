class StacksController < ApplicationController
  def new
    logged_in_checker {
      current_user_is_generic {
        @stack = Stack.new
      }
    }
  end

  def create
    logged_in_checker {
      current_user_is_generic {
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
          redirect_to(@stack)
        else
          render 'edit'
        end
      }
    }
  end

  def add_stacker
    logged_in_checker {
      @stack = Stack.find(params[:id])
      current_user_belongs_to_stack {
        @stackers = @stack.stackers
        @stackees = @stack.stackees
        @users = User.where("type = ''").all
      }
    }
  end

  def show
    logged_in_checker {
      @stack = Stack.find(params[:id])
      current_user_belongs_to_stack {
        @stackers = @stack.stackers
        @stackees = @stack.stackees
        render 'show'
      }
    }
  end

  def index
    logged_in_checker {
      called_by_admin {
        @stacks = Stack.all
      }
    }
  end

  def destroy
    logged_in_checker {
      called_by_admin {
        @stack = Stack.find(params[:id])
        @stack.stackers.each do |stacker|
          stacker.update(type: '', stack_id: nil)
        end
        @stack.destroy
        redirect_to stacks_url
      }
    }
  end

  private
    def current_user_belongs_to_stack
      if current_user.stack_id == @stack.id
        yield
      elsif current_user.admin?
        yield
      else
        redirect_to show_user_url(current_user)
      end
    end

    def current_user_is_generic
      if current_user.type.nil? or current_user.type.empty?
        yield
      else
        redirect_to show_user_url(current_user)
      end
    end
    
    def stack_params
      params.require(:stack).permit(:name, :description, stackers: [], stackees: [])
    end
end
