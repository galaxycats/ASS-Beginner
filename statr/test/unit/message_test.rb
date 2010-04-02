require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  
  test "should have a user" do
    message = Message.create
    assert message.errors[:user], "There should be an error on :user if no user is associated"
  end
  
  test "should have a content" do
    message = Message.create
    assert message.errors[:content], "There should be an error on :content if no content is set"
  end
  
  test "should have a content with at least one character" do
    message = Message.create(:content => "")
    assert message.errors[:content], "There should be an error on :content if no content is set"
    message = Message.create(:content => "12")
    assert message.errors[:content].empty?, "There should be no error on :content if there is at least one character"
  end
  
end