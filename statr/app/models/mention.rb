class Mention < ActiveRecord::Base
  belongs_to :message
  belongs_to :mentioned_user, :class_name => "User", :foreign_key => "mentioning_id"
  
  def content
    message.content
  end
  
  def user
    message.user
  end
end
