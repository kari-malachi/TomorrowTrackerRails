class StacksController < ApplicationController
  def new
    logged_in_checker {
      @stack = Stack.new
    }
  end

  def create
    logged_in_checker {
      @stack = Stack.new(stack_params)
      if @stack.save
        @current_user.type = 'Stacker'
        #TODO
    }

end
