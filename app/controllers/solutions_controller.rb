class SolutionsController < ApplicationController
  def new
    logged_in_checker {
      @solution = Solution.new
    }
  end

  def create
    logged_in_checker {
      @solution = Solution.new(solution_params)
      if @solution.save
        redirect_to show_clue_url(params[:clue_id])
      else
        render 'new'
      end
    }
  end

  def edit
    logged_in_checker {
      @solution = Solution.find(params[:id])
    }
  end

  def update
    logged_in_checker {
      @solution = Solution.find(params[:id])
      if @solution.update(solution_params)
        redirect_to show_clue_url(params[:clue_id])
      else
        render 'edit'
      end
    }
  end
end
