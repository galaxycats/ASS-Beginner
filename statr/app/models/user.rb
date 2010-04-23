class User < ActiveRecord::Base
  has_many :mentions, :class_name => "Mention", :foreign_key => "mentioning_id"
  has_many :messages
  has_and_belongs_to_many :followees,
    :join_table  => "followees",
    :class_name  => "User",
    :foreign_key => "followee_id" do
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
    Message.
      where("messages.user_id IN (:user_ids) OR mentioning_id IN (:my_user_id)", {
        :user_ids => followees.collect(&:id) << self.id,
        :my_user_id => self.id
      }).
      select("DISTINCT(messages.content) AS content, messages.*").
      joins('LEFT JOIN "users" ON "users"."id" = "messages"."user_id" LEFT JOIN "mentions" ON "mentions"."mentioning_id" = "users"."id" LEFT JOIN "messages" AS "messages_mentions" ON "messages_mentions"."id" = "mentions"."message_id"').
      order("messages.created_at DESC")
  end
  
  def follow(user)
    followees << find_user(user)
  end
  
  def unfollow(user)
    followees.delete(find_user(user))
  end
  
  def follows?(user)
    !!followees.find_by_username(user.username)
  end
  
  private
  
    def find_user(user_or_username)
      user_or_username.is_a?(User) ? user_or_username : User.find_by_username(user_or_username)
    end
end
