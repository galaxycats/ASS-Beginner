class SessionsController < ApplicationController

  def create
    @session = Session.new(params[:session])
    if @session.valid?
      session[:current_user_id] = @session.user
      redirect_to user_url(@session.user)
    else
      render :action => "new"
    end
  end

  def new
    @session = Session.new
  end

  def destroy
    session[:current_user_id] = nil
    reset_session
    
    redirect_to root_url
  end

end
