# frozen_string_literal: true

module SessionsHelper
  # Logs in the given user.
  def log_in(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.r_token
  end

  # Logs out current user
  def log_out
    @current_user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
    @current_user = nil
  end
  
  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user == @current_user
  end

  # Returns the current logged-in user (if any).
  def current_user
    if user_id = cookies.signed[:user_id]
      user = User.find_by(id: user_id)
      if user &.authentic_token?(cookies[:remember_token])
        @current_user = user
      end
    end
  end
end
