class SessionsController < ApplicationController
  attr_reader :errors
  
  before_action :authenticate_user, :only => [:home]
  before_action :save_login_state, :only => [:login, :login_attempt]
  
  def login
    @session = Session.new
  end

  def logout
    session[:user_id] = nil
    redirect_to 'login'
  end

  def home
    @session = Session.find(params[:id])
  end

  def login_attempt
    @session = Session.new
    authorized_user = User.authenticate(params[:username], params[:password])
    if authorized_user
      session[:user_id] = authorized_user.id
      redirect_to :action => 'home'
    else
      @session.errors.add(:login, 'failed. Invalid username or password.')
      render 'login'
    end
  end
end
