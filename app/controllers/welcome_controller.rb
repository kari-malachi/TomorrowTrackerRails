class WelcomeController < ApplicationController
  def index
    not_logged_in_checker {}
  end
end
