class SolutionsController < ApplicationController
  def new
    logged_in_checker {
      current_user_owns_this_clue {
        @solution = Solution.new
      }
    }
  end

  def create
    logged_in_checker {
      current_user_owns_this_clue {
        @solution = Solution.new(solution_params)
        if @solution.save
          redirect_to show_clue_url(stack_id: @stack, id: @clue)
        else
          render 'new'
        end
      }
    }
  end

  def edit
    logged_in_checker {
      current_user_owns_this_clue {
        @solution = Solution.find(params[:id])
      }
    }
  end

  def update
    logged_in_checker {
      current_user_owns_this_clue {
        @solution = Solution.find(params[:id])
        if @solution.update(solution_params)
          redirect_to show_clue_url(stack_id: @stack, id: @clue)
        else
          render 'edit'
        end
      }
    }
  end

  def destroy
    logged_in_checker {
      current_user_owns_this_clue {
        @solution = Solution.find(params[:id])
        @solution.destroy
        redirect_to show_clue_url(stack_id: @stack, id: @clue)
      }
    }
  end

  private
    def solution_params
      params.require(:solution).permit(:content, :next_clue_id, :clue_id)
    end

    def current_user_owns_this_clue
      @clue = Clue.find(params[:clue_id])
      if @clue.stack_id == current_user.stack_id
        @stack = Stack.find(params[:stack_id])
        yield
      else
        redirect_to show_user_url(@current_user)
      end
    end
end
