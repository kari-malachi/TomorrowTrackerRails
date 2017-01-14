class AssignmentsController < ApplicationController
  def current_objectives
    logged_in_checker {
      current_user_is_on_stack {
        @current_clues = []
        @user.assignments.each do |assignment|
          if !assignment.complete
            @current_clues << assignment.clue
          end
        end
      }
    }
  end

  def finished_objectives
    logged_in_checker {
      current_user_is_on_stack {
        @finished_clues = []
        @user.assignments.each do |assignment|
          if assignment.complete
            @finished_clues << assignment.clue
          end
        end
      }
    }
  end

  private
    def current_user_is_on_stack
      @user = current_user
      @stack = Stack.find(params[:stack_id])
      if @user.stackee? and @user.belongs_to_stack?(@stack.id)
        yield
      else
        redirect_to show_user_url(@user)
      end
    end
end
