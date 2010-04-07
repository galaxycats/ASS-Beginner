require 'test_helper'

class MentionTest < ActiveSupport::TestCase
  
  test "should belongs to a message" do
    mention = Mention.new(:message => Message.new)
    assert_not_nil mention.message
  end
  
  test "should belongs to the user that was mentioned in the associated message" do
    mention = Mention.new(:mentioned_user => User.new)
    assert_not_nil mention.mentioned_user
  end
  
  test "should delegate the content to the associated message" do
    mention = Mention.new(:message => message = Message.new)
    message.expects(:content)
    mention.content
  end
  
  test "should delegate owning user to the associated message" do
    mention = Mention.new(:message => message = Message.new)
    message.expects(:user)
    mention.user
  end
  
end
