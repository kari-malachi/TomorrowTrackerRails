class CluesController < ApplicationController
  def new
    logged_in_checker {
      current_user_owns_this_stack {  
        @stack = Stack.find(@current_user.stack_id)
        @clue = Clue.new
      }
    }
  end

  def create
    logged_in_checker {
      current_user_owns_this_stack {
        @clue = Clue.new(clue_params)
        if @clue.save
          redirect_to view_tree_path(@clue.stack)
        else
          render 'new'
        end
      }
    }
  end

  def edit
    logged_in_checker {
      current_user_owns_this_stack {
        @stack = Stack.find(@current_user.stack_id)
        @clue = Clue.find(params[:id])
      }
    }
  end

  def update
    logged_in_checker {
      current_user_owns_this_stack {
        @clue = Clue.find(params[:id])
        @clue.update(clue_params)
      }
    }
  end

  def show
    logged_in_checker {
      if current_user.belongs_to_stack?(@stack.id)
        @clue = Clue.find(params[:id])
        @in_progress = []
        @completed = []
        @clue.assignments.each do |assignment|
          if assignment.complete
            @completed << assignment.stackee
          else
            @in_progress << assignment.stackee
          end
        end
      else
        redirect_to show_user_url(@current_user)
      end
    }
  end

  private
    def clue_params
      params.require(:clue).permit(:stack, :title, :content)
    end

    def current_user_owns_this_stack
      if current_user.belongs_to_stack?(params[:stack_id]) and
         current_user.stacker?
        yield
      else
        redirect_to show_user_url(@current_user)
      end
    end
end
