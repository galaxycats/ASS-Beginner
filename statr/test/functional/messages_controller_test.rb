require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  
  test "should only grant access to create action for loggin users" do
    post :create
    assert_response :redirect, @response.body
    
    login_user
    @controller.expects(:current_user).at_least_once.returns(user = mock("UserMock"))
    user.expects(:messages).returns(messages = mock("MessagesCollectionMock"))
    messages.expects(:build).with("content" => "A status update for testing purpose").returns(message = mock("MessageMock"))
    message.expects(:save).returns(true)
    post :create, :message => {:content => "A status update for testing purpose"}
    assert_response :redirect, @response.body
  end
  
end
