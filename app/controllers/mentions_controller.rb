class MentionsController < ApplicationController
  
  def index
    @user = User.find_by_username(params[:user_id])
    @messages = @user.mentions
    
    render :template => "users/show"
  end
  
end