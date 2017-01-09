class CluesController < ApplicationController
  def new
    logged_in_checker {
      current_user_owns_a_stack {  
        @stack = Stack.find(@current_user.stack_id)
        @clue = Clue.new
      }
    }
  end

  def edit
    logged_in_checker {
      current_user_owns_a_stack {
        @stack = Stack.find(@current_user.stack_id)
        @clue = Clue.find(params[:id])
      }
    }
  end

  def show
    logged_in_checker {
      @clue = Clue.find(params[:id])
    }
  end

  def view_tree
    logged_in_checker {
      current_user_owns_a_stack {
        @stack = Stack.find(@current_user.stack_id)
        @clues = @stack.clues
      }
    }
  end

end
