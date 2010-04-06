require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  
  test "should have a user" do
    message = Message.new
    assert !message.valid?
    assert message.errors.include?(:user), "There should be an error on :user if no user is associated"
  end
  
  test "should have a content" do
    message = Message.new
    assert !message.valid?
    assert message.errors.include?(:content), "There should be an error on :content if no content is set"
  end
  
  test "should have a content with at least one character and a maximum of 140 characters" do
    message = Message.new(:content => "")
    assert !message.valid?
    assert message.errors.include?(:content), "There should be an error on :content if no content is set"
    
    message = Message.new(:content => "c"*141)
    assert !message.valid?
    assert message.errors.include?(:content), "There should be an error on :content is more then 140 characters"
    
    message = Message.new(:content => "This is status update post")
    message.valid?
    assert !message.errors.include?(:content), "There should be no error on :content"
  end
  
  test "should have a scope to list the latest message first" do
    Message.create(:user => users(:natsume), :content => "Older status update", :created_at => Time.now - 2.day)
    Message.create(:user => users(:natsume), :content => "Newer status update", :created_at => Time.now - 1.day)
    
    assert_operator Message.latest.first.created_at, :>, Message.latest.last.created_at
  end
  
  test "should create a mention if some user was mentioned in the message content" do
    message = Message.new(:user => users(:natsume), :content => "@zoro, I mentioned you!")

    User.expects(:find_by_username).with("zoro").returns(zoro = mock("UserMock"))
    Mention.expects(:create).with(:message => message, :mentioned_user => zoro)

    message.save
  end
  
end