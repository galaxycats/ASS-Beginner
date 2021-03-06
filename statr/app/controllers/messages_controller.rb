class MessagesController < ApplicationController

  before_filter :require_login, :only => [:create]
  
  before_filter :load_latest_messages
  
  def create
    @message = current_user.messages.build(params[:message])
    if @message.save
      redirect_to user_url(current_user)
    else
      render :action => "index"
    end
  end
  
  private
    
    def load_latest_messages
      @messages = Message.latest
    end
    
end
