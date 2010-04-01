class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user, :logged_in?
  
  def current_user
    @current_user ||= User.find(session[:current_user_id]) if session[:current_user_id]
  end
  
  def logged_in?
    !!current_user
  end
end
