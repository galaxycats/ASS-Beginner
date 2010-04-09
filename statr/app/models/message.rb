class Message < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :content
  validates_length_of :content, :within => 1..140
  
  validates_presence_of :user
  
  after_create :associate_message_to_users_that_have_been_mentioned
  
  scope :latest, :order => "created_at DESC"
  
  private
  
    def associate_message_to_users_that_have_been_mentioned
      mentioned_users = content.scan(/@([\w\d]+)/).flatten
      
      mentioned_users.each do |mentioned_user|
        Mention.create(
          :message        => self,
          :mentioned_user => User.find_by_username(mentioned_user)
        )
      end
    end
end