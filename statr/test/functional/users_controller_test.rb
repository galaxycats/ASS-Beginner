require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  test "should grant access to follow action only to logged in users" do
    post :follow, :id => "zoro"
    assert_response :redirect, @response.body
    
    login_user
    @controller.expects(:current_user).at_least_once.returns(mock("UserMock", :follow => true))
    post :follow, :id => "zoro"
    assert_response :redirect, @response.body
  end
  
  test "should grant access to unfollow action only to logged in users" do
    post :unfollow, :id => "zoro"
    assert_response :redirect, @response.body
    
    login_user
    @controller.expects(:current_user).at_least_once.returns(mock("UserMock", :unfollow => true))
    post :unfollow, :id => "zoro"
    assert_response :redirect, @response.body
  end
  
end
