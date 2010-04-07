require 'test_helper'

class UsersHelperTest < ActionView::TestCase
  
  test "should render the follow button the current_user isn't following the other user" do
    self.expects(:logged_in?).returns(true)
    current_user = User.new
    @user = mock("UserMock")
    current_user.expects(:follows?).at_least_once.with(@user).returns(false)
    self.expects(:current_user).at_least_once.returns(current_user)
    self.expects(:button_to)
    self.expects(:follow_user_url).with(@user)
    
    assert_not_nil follow_user_button
  end
  
  test "should render the unfollow button the current_user is following the other user" do
    self.expects(:logged_in?).returns(true)
    current_user = User.new
    @user = mock("UserMock")
    current_user.expects(:follows?).at_least_once.with(@user).returns(true)
    self.expects(:current_user).at_least_once.returns(current_user)
    self.expects(:button_to)
    self.expects(:unfollow_user_url).with(@user)
    
    assert_not_nil follow_user_button
  end
  
  test "should render no button the current_user is the other user" do
    self.expects(:logged_in?).returns(true)
    current_user = User.new
    @user = current_user
    self.expects(:current_user).returns(current_user)
    
    assert_equal "", follow_user_button
  end
  
  test "should render only if someone is logged in" do
    self.expects(:logged_in?).returns(false)
    assert_nil follow_user_button
  end
  
end
