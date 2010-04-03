class User < ActiveRecord::Base
  has_many :mentions, :class_name => "Mention", :foreign_key => "mentioning_id"
  has_many :messages
  has_many :followees, :class_name => "User", :foreign_key => "followee_id" do
    def messages
      Message.where(:user_id => proxy_owner.followees.map(&:id))
    end
  end
  has_many :followers, :class_name => "User", :foreign_key => "follower_id"
  
  validates_presence_of :first_name, :last_name
  validates_presence_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_uniqueness_of :username
  
  def real_name
    [first_name, last_name].join(" ")
  end
  
  def to_param
    username
  end
  
  def all_messages
    (messages + mentions + followees.messages.all).sort { |message, another_message| another_message.created_at <=> message.created_at }
  end
  
  def follow(user)
    follow_unfollow(user) do |user|
      followees << user
      user.followers << self
    end
  end
  
  def unfollow(user)
    follow_unfollow(user) do |user|
      followees.delete(user)
      user.followers.delete(self)
    end
  end
  
  def follows?(user)
    followees.find_by_username(user.username)
  end
  
  private
  
    def follow_unfollow(user, &block)
      user = user.is_a?(User) ? user : User.find_by_username(user)
      yield user
      save and user.save
    end
end
