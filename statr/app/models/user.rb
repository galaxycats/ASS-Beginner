class User < ActiveRecord::Base
  has_many :mentions, :class_name => "Mention", :foreign_key => "mentioning_id"
  has_many :messages
  has_and_belongs_to_many :followees, :join_table => "followees", :class_name => "User", :foreign_key => "followee_id" do
    def messages
      Message.where(:user_id => proxy_owner.followees.map(&:id))
    end
  end
  
  validates_presence_of :first_name, :last_name, :username
  validates_presence_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_uniqueness_of :username
  
  attr_accessor :password
  
  def real_name
    [first_name, last_name].join(" ")
  end
  
  def to_param
    username
  end
  
  def all_messages
    (messages + mentions + followees.messages.all).uniq_by {|msg| msg.content}.sort { |message, another_message| another_message.created_at <=> message.created_at }
  end
  
  def follow(user)
    followees << find_user(user)
  end
  
  def unfollow(user)
    followees.delete(find_user(user))
  end
  
  def follows?(user)
    followees.find_by_username(user.username)
  end
  
  private
  
    def find_user(user_or_username)
      user_or_username.is_a?(User) ? user_or_username : User.find_by_username(user_or_username)
    end
end
