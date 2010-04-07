class Session
  extend ActiveModel::Naming
  include ActiveModel::Validations

  attr_accessor :username, :password
  
  validates_presence_of :username, :message => "must be given"
  validates_presence_of :password, :message => "must be given"
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