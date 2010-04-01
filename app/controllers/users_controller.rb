class UsersController < ApplicationController
  
  def show
    @user = User.find_by_username(params[:id])
    @messages = if logged_in? and current_user == @user
      @user.all_messages
    else
      @user.messages
    end
  end
  
  def follow
    current_user.follow(params[:id])
    redirect_to user_url(current_user)
  end

  def unfollow
    current_user.unfollow(params[:id])
    redirect_to user_url(current_user)
  end
  
end
