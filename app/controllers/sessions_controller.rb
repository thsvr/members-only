class SessionsController < ApplicationController
  include SessionsHelper

  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user &.authenticate(params[:session][:password])
      flash.now[:success] = 'Sucessfully logged in'
      log_in @user
      # redirect_to login_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
