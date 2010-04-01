class Session
  extend ActiveModel::Naming
  include ActiveModel::Validations

  attr_accessor :username, :password
  
  validates_presence_of :username
  validates_presence_of :password
  validates_with UsernamePasswordValidator
  
  def initialize(attributes = {})
    attributes.each do |attr, value|
      self.send("#{attr}=", value)
    end
  end
  
  def user
    @user ||= User.find_by_username(self.username)
  end

end