class CluesController < ApplicationController
  def new
    logged_in_checker {
      current_user_owns_this_stack {  
        @clue = Clue.new
      }
    }
  end

  def create
    logged_in_checker {
      current_user_owns_this_stack {
        @clue = Clue.new(clue_params)
        if @clue.save
          redirect_to clue_tree_path(@stack)
        else
          render 'new'
        end
      }
    }
  end

  def edit
    logged_in_checker {
      current_user_owns_this_stack {
        @clue = Clue.find(params[:id])
      }
    }
  end

  def update
    logged_in_checker {
      current_user_owns_this_stack {
        @clue = Clue.find(params[:id])
        if @clue.update(clue_params)
          redirect_to show_clue_path(stack_id: @stack, id: @clue)
        else
          render 'edit'
        end
      }
    }
  end

  def show
    logged_in_checker {
      @stack = Stack.find(params[:stack_id])
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

  def destroy
    logged_in_checker {
      current_user_owns_this_stack {
        @clue = Clue.find(params[:id])
        @clue.destroy
        redirect_to clue_tree_path(@stack)
      }
    }
  end

  private
    def clue_params
      params.require(:clue).permit(:stack_id, :title, :content)
    end

    def current_user_owns_this_stack
      @stack = Stack.find(params[:stack_id])
      if current_user.belongs_to_stack?(@stack.id) and
         current_user.stacker?
        yield
      else
        redirect_to show_user_url(@current_user)
      end
    end
end
