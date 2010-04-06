class UsersController < ApplicationController
  
  before_filter :require_login, :only => [:follow, :unfollow]
  
  def show
    if @user = User.find_by_username(params[:id])
      @messages = if logged_in? and current_user == @user
        @user.all_messages
      else
        @user.messages
      end
    else
      flash[:error] = "We couldn't find the user with the username '#{params[:id]}'."
      render "shared/404", :status => 404
    end
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      session[:current_user_id] = @user.id
      redirect_to user_url(@user)
    else
      render :new
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
